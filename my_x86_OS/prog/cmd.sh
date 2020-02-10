#as -nostdlib -a=boot.lst -o boot.img boot.s
#ld -N -e start -Ttext=0x7c00 -o boot.o boot.img
#objcopy -O binary boot.o boot.bin
#ld -melf_i386 -T test.ld test.o -o test.bin -nostdlib --nmagic
#gcc -c test.s -m16
#qemu-system-i386 -drive file=boot.bin,format=raw
#objdump -D -b binary -mi386 -Maddr16, data16 mbr
as -nostdlib -a=./src/boot.lst -o boot.img boot.s
ld -N -e start -Ttext=0x7c00 -o boot.o boot.img
objcopy -O binary boot.o boot.bin
#ld -melf_i386 -T test.ld test.o -o test.bin -nostdlib --nmagic
#gcc -c test.s -m16
qemu-system-i386 -drive file=boot.bin,format=raw
#objdump -D -b binary -mi386 -Maddr16, data16 mbr
