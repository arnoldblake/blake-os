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
	BPS	dw 512				; Bytes per logical sector
	SPC	db 1				; Logical sectors per cluster
		dw 1				; Reserved logical sectors
	NOF	db 2				; Number of FATs
	RDE	dw 224				; Root directory entries
		dw 2880				; Total logical sectors
		db 240				; Media descriptor
	SPF	dw 9				; Logical sectors per FAT
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

; ------------------------------------------------------------------
; Start of our bootloader code the goal here is to load the FAT12
; root directory to memory and search for our kernel file. Load
; the kernel to memory and begin to execute our kernel code. 
; ------------------------------------------------------------------
bootloader: ; Setup segment registers and the stack
	mov ax, 0x7C0
    mov ds, ax
	mov es, ax
	mov ss, ax
	mov bp, 0x9000
	mov sp, bp

    mov [boot_device], dl	; Store boot_device

; LBA for root dir convert to CHS format
	mov ax, 19 
	call lba2chs

; Read root dir to memory 
	mov bx, buffer
	mov ah, 2
	mov al, 14
	mov dl, [boot_device]
	int 0x13


	mov si, kernel_file_name
	mov di, buffer
	xor cx, cx
	mov cx, 8
	push di
.loop:
	rep cmpsb
	jne .nomatch
; ------------------------------------------------------------------
; Match found
; Pop di which stores our most recent root directory entry offset
; 
	pop di
	mov ax,	di 
	mov bx, 32
	call print_string2

.nomatch:
	pop di
	mov si, kernel_file_name
	mov di, buffer
	add di, 32
	push di
	jmp .loop


end:
	mov ax, MSG_NO_KERNEL_FOUND
	call print_string
	jmp $
	
%include "source/lib/lba2chs.asm"
%include "source/lib/print_string.asm"
%include "source/lib/print_string2.asm"

; ------------------------------------------------------------------	
	boot_device db 0	; Boot device value
	kernel_file_name	db "KERNEL  "	; File name of our kernel
	MSG_NO_KERNEL_FOUND db "Could not find kernel", 0
; ------------------------------------------------------------------
; Pad out remaining space and set the bootsignature bytes
; ------------------------------------------------------------------
	times 510-($-$$) db 0	; Pad with zero
	dw 0xAA55		        ; Boot signature

buffer:
