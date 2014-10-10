; ==================================================================
; FILE: disk.asm AUTHOR: Blake Arnold DATE: 10-10-2014
; PURPOSE: Read sectors from disk to memory.
; IN AL (read sectors), CH (cylinder), CL (sector), DH (head)
; ES:BX (destination address)
; =================================================================
