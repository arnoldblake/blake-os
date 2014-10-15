; ==================================================================
; FILE: kernel.asm AUTHOR: Blake Arnold DATE: 10-13-2014
; PURPOSE: This is our main kernel program.
; =================================================================

; Generic re implementation of our print function to see if
; we made it into kernel code.
kstart:
	mov ax, 0			; Set stack segment to 0
	mov ss, ax
	mov sp, 0xFFFF		; Move stack pointer to the top of the segment

	mov ax, 0x2000		; Set all segment registers to segment where
	mov ds, ax			; we have loaded kernel into memory
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov bx, MSG_KERNEL
	mov ah, 0x0E
kprint_start:
	mov al, [bx]
	int 0x10
	add bx, 1
	cmp byte [bx], 0
	jne kprint_start
	
	jmp $

	MSG_KERNEL db "Welcome to Kernel",0
