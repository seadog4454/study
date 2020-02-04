as -a=boot.lst -o boot.img boot.s
ld -T link.ld boot.img -o boot.bin
objdump -D -b binary -m i386 boot.bin
qemu-system-x86_64 -drive file=boot.bin,format=raw
