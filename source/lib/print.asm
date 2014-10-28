; ==================================================================
; FILE: print.asm AUTHOR: Blake Arnold DATE: 10-10-2014
; PURPOSE: Uses BIOS interupt 0x10 to print a null terminated 
; string to the output.
; PARAMETERS: SI Null terminated string to print
; ==================================================================

print:
	lodsb
	or	 	al, al
	jz		.end
	mov 	ah, 0x0e
	int 	0x10
	jmp 	print
.end:
	ret
