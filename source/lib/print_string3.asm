; ==================================================================
; FILE: print.asm AUTHOR: Blake Arnold DATE: 10-24-2014
; PURPOSE: Uses BIOS interrupt 0x10 to print
; PARAMETERS: SI Address of string to write
; ==================================================================

print_string3:
	lodsb
	or al, al
	jz print_string3_end:
	mov ah, 0x0E
	int 0x10
	jmp print_string3:
print_string3_end: