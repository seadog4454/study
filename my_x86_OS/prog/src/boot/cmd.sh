as -a=boot.lst -o boot.o boot.s
as -a=kernel.lst -o kernel.o kernel.s

ld -T link.ld boot.o -o boot.bin
ld -T link_kernel.ld kernel.o -o kernel.bin

cat boot.bin kernel.bin > boot.img 

#ld -N -e _start -Ttext=0x7c00 -o boot.o boot.img
#objcopy -O binary boot.o boot.bin
qemu-system-x86_64 -drive file=boot.img,format=raw
