# Makefile Variables

# NASM Variables
COMPILER=nasm $(NASM_FLAGS)
NASM_FLAGS=-O0 -w+orphan-labels -f bin

# DD Variables
DD_FLAGS=status=noxfer conv=notrunc

all: assemble floppy
	mount -o loop -t vfat bin/blakeos.flp tmp
	cp source/kernel.bin tmp
	sleep 1
	umount tmp

floppy:
	mkdosfs -C bin/blakeos.flp 1440
	dd $(DD_FLAGS) if=source/bootloader.bin of=bin/blakeos.flp

assemble:
	nasm $(NASM_FLAGS) -o source/bootloader.bin source/bootloader.asm
	nasm $(NASM_FLAGS) -o source/kernel.bin source/kernel.asm
	
dump:
	hexdump -C bin/blakeos.flp

clean:
	rm bin/blakeos.flp
	rm source/bootloader.bin
	rm source/kernel.bin
