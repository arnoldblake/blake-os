run:
	bochs

floppy: bootload.bin
	mkdosfs -C bin/blakeos.flp 1440
	dd status=noxfer conv=notrunc if=source/bootloader/bootloader.bin of=bin/blakeos.flp

bootloader.bin:
	nasm -O0 -w+orphan-labels -f bin source/bootloader/bootloader.asm -o source/bootloader/bootloader.bin
	
clean:
	rm -rf ./*.bin ./*.o ./*.dis ./*.flp

disassemble: bootloader.bin
	od -t x1 -A n source/bootloader/bootloader.bin
