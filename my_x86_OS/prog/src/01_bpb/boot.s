.equ BOOT_LOAD, 0x7C00


.code16
.text
.global start

start:
  jmp ipl

  # BPB
  .org 90 - (. - start), 0x90

  # IPL
 ipl:
  cli
  mov $0x0000, %ax
  mov %ax, %dx
  mov %ax, %es
  mov %ax, %ss
  mov $BOOT_LOAD, %sp
  sti
  movb %dl, drive
  
  mov $0x41, %al
  mov $0x0E, %ah
  mov $0x0000, %bx
  int $0x10

  jmp .

.align 2
BOOT:
  # .fill 0x18c, 0x1, 0x0
  # .org 510 - (. - ipl - 0x19), 0x0
  .word 0xAA55

.data
  drive: .byte 0xBB
