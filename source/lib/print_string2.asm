; ==================================================================
; FILE: print.asm AUTHOR: Blake Arnold DATE: 10-10-2014
; PURPOSE: Uses BIOS interupt 0x10 to print a null terminated 
; string to the output.
; IN AX (address of null terminated string), BX Counter
; ==================================================================

print_string2:
	mov cx, bx
	mov bx, ax
	mov ah, 0x0E
print_string2_start:
	mov al, [bx]
	int 0x10
	add bx, 1
	sub cx, 1
	cmp cx, 0
	jg print_string2_start
	ret
