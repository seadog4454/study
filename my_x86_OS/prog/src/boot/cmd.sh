as -a=boot.lst -o boot.img boot.s
ld -N -e _start -Ttext=0x7c00 -o boot.o boot.img
objcopy -O binary boot.o boot.bin
qemu-system-x86_64 -drive file=boot.bin,format=raw
