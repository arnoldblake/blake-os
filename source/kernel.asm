; ==================================================================
; FILE: kernel.asm AUTHOR: Blake Arnold DATE: 10-13-2014
; PURPOSE: This is our main kernel program.
; =================================================================

kstart:
	mov ax, 0			; Set stack segment to 0
	mov ss, ax
	mov sp, 0xFFFF		; Move stack pointer to the top of the segment

	mov ax, 0x2000		; Set all segment registers to segment where
	mov ds, ax			; we have loaded kernel into memory
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov si, MSG_KERNEL
	call print
	jmp $

%include "source/lib/print.asm"

	MSG_KERNEL db "Welcome to Kernel",0
