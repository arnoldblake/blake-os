# Blake-OS
## Overview
  This is my delve into the world of OS development. I have been interested in OS development for a while and have learned quite a bit since my frist attempt. With that said I believe I have reached a point where the information I have could be useful to anyone else that is also interested in OS development. I will keep the information here as up to date as I can manage. My motivation was [os-dev.pdf](http://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf) which I came across in a hackernews post. I found it vastly more straight forward and simple than my previous work sourced from http://osdev.org.

## Getting Started
  In the following sections I will describe my build process, the software I use, and the basic requirements to get the computer to execute our code. At this point I have writtent all of my code in assembly. I have utilized a [Makefile](https://github.com/arnoldblake/blake-os/blob/master/Makefile) to aid in build and debug time. I am using the bochs emulator which is configured with a floppy image formatted with the FAT12 file system.
  
### Environment
  For my build and testing environment I am using Ubuntu 14, nasm, bochs, and bochs-sdl.
  
### File Structure
  I have laid out the file structure with a root directory containing; the doc folder for documentation, the source directory which obviously containts the source code for building the bootloader, kernel, and the library files. Also in the root directory is the bochsrc script and the makefile.
  
### Booting
  My overly simplified view of the boot process is: The computer is powered on, followed by the POST and loading of the BIOS. The BIOS then searches the first sector of each device for the word 0x55AA in the last two bytes of the sector. If it finds one such sector, the BIOS will copy that sector to memory address 0x7C00 and begin executing from that point.
  
![Boot Sector Byte Diagram](https://github.com/arnoldblake/blake-os/blob/master/doc/images/boot_sector_byte_diagram.png)
  
## Refrences
* [os-dev.pdf](http://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf)
* http://osdev.org
* [Boot Sector in C](http://crimsonglow.ca/~kjiwa/x86-dos-boot-sector-in-c.html)
* [Mikeos](http://mikeos.sourceforge.net/)
* [DOS Bootloader](http://www.tburke.net/info/ntldr/bootsect.txt)
