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
  db 0, 0		; Ignored (8 - 10)
  dw 512		; Bytes per logical sector
  db 1			; Logical sectors per cluster
  dw 1			; Reserved logical sectors
  db 2			; Number of FATs
  dw 224		; Root directory entries
  dw 2880		; Total logical sectors
  db 0			; Media descriptor
  dw 9			; Logical sectors per FAT
  dw 18			; Physical sectors per track
  dw 2			; Number of heads
  dd 0			; Hidden sectors
  dd 0			; Large total logical sectors
  db 0			; Physical drive number
  db 0			; Flags etc.
  db 41			; Boot signature
  dd __POSIX_TIME__	; Volume serial number
  db "           "	; Volume label
  db "FAT12   "		; File system type
; ------------------------------------------------------------------

bootloader:
  mov [boot_device], dl	; Store boot_device
  jmp $

%include "../lib/lba2chs.asm"

; ------------------------------------------------------------------	
	boot_device db 0	; Boot device value

; ------------------------------------------------------------------
; Pad out remaining space and set the bootsignature bytes
    times 510-($-$$) db 0	; Pad with zero
    dw 0AA55h		        ; Boot signature
