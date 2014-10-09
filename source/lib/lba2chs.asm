; ==================================================================
; FILE: lba2chs.asm AUTHOR: Blake Arnold DATE: 10-09-2014
; PURPOSE: Convert Logical Block Address to Cylinder Head Sector
; address. Result is stored in cx and dh in anticipation of int 13h.
; The 
; 
; ==================================================================

lba2chs:
	xor cx, cx		; Zero cx
	xor dx, dx		; Zero dx
	div word 18		; Divide ax by 18 (sectors per track)
	inc dx			; Increment dx
	mov cl, dl		; Store dl (sector) into cl
	xor dx, dx		; Zero dx
	div word 2		; Divide ax by 2 (heads per cylinder)
	mov dh, dl		; Store dl (head) into dh
	mov ch, al		; Store al (cylinder) into ch
	ret
	
	