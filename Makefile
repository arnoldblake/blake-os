floppy: bootload.bin
	mkdosfs -C bin/blakeos.flp 1440
	dd status=noxfer conv=notrunc if=source/bootloader/bootloader.bin of=bin/blakeos.flp

bootload.bin: bootload.asm
	nasm -O0 -w+orphan-labels -f bin -o source/bootloader/bootloader.asm
	
clean:
	rm -rf *.bin *.o *.dis *.flp