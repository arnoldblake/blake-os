; ==================================================================
; FILE: bootloader.asm AUTHOR: Blake Arnold DATE: 10-09-2014
; PURPOSE: Bootloader written for FAT12 file system. This file must
; be no larger than 510 bytes and the final two bytes must be set
; to AA55 for boot signature. Given our build process we can create
; the FAT12 information manually (see FAT12 pdf in doc).
; ==================================================================

	BITS 16
	jmp short bootloader

; ------------------------------------------------------------------
; FAT12 Boot Sector BIOS parameter block
; ------------------------------------------------------------------
		dq 0				; Ignored (8 - 10)
		db 0
		dw 512				; Bytes per logical sector
		db 1				; Logical sectors per cluster
		dw 1				; Reserved logical sectors
		db 2				; Number of FATs
	RDE	dw 224				; Root directory entries
		dw 2880				; Total logical sectors
		db 240				; Media descriptor
		dw 9				; Logical sectors per FAT
; ------------------------------------------------------------------
	SPT dw 18				; Physical sectors per track
	HPC	dw 2				; Number of heads
		dd 0				; Hidden sectors
		dd 0				; Large total logical sectors
; ------------------------------------------------------------------
		db 0				; Physical drive number
		db 0				; Flags etc.
		db 41				; Boot signature
		dd __POSIX_TIME__	; Volume serial number
		db "           "	; Volume label
		db "FAT12   "		; File system type
; ------------------------------------------------------------------

bootloader:
	mov ax, 0x7C0			; Where we are loaded in memory
    mov ds, ax				; Into the data segment
	mov ss, ax				; Also into the stack segment

	mov bp, 0x9000			; Setup stack space
	mov sp, bp

    mov [boot_device], dl	; Store boot_device

	mov ax, 19				; Convert LBA 19 to CHS format
	call lba2chs

	mov ah, 2				; Prepare to read 14 sectors from
	mov al, 1				; floppy disk into memory at es:bx
	mov dl, [boot_device]
	mov bx, ds
	mov	es, bx 				 
	mov bx, buffer			
	int 0x13

	mov ax, buffer
	add ax, 32
	mov bx, 16
	call print_string2
; ------------------------------------------------------------------
; At this point we should have loaded the FAT12 root directory into
; memory at es:bx. 

	jmp $
	
%include "source/lib/lba2chs.asm"
%include "source/lib/print_string2.asm"

; ------------------------------------------------------------------	
	boot_device db 0	; Boot device value

; ------------------------------------------------------------------
; Pad out remaining space and set the bootsignature bytes
	times 510-($-$$) db 0	; Pad with zero
	dw 0xAA55		        ; Boot signature

buffer:
