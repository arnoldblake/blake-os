; ==================================================================
; FILE: print.asm AUTHOR: Blake Arnold DATE: 10-10-2014
; PURPOSE: Uses BIOS interupt 0x10 to print a null terminated 
; string to the output.
; IN AX (address of null terminated string)
; ==================================================================

print_string:
	pusha
	mov bx, ax
	mov ah, 0x0E
print_string_start:
	mov al, [bx]
	int 0x10
	add bx, 1
	cmp byte [bx], 0
	jne print_string_start
	popa
	ret
