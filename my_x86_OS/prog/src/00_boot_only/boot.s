.code16
.text
.global _start



_start:
  jmp ipl

  # BPB
  
  .org 90 - (. - _start), 0x90

  # IPL
 ipl:
  cli
  mov $0x0000, %ax
  mov %ax, %dx
  mov %ax, %es
  mov %ax, %ss
  mov (BOOT_LOAD), %sp
  sti
  mov %dl, drive
  

  # push $0x41
  # call putc
  # add $2, %sp
  
  
  push $s0
  call puts
  add $2, %sp

/*
  push $0b0000
  push $10
  push $8
  push $s1
  pushw $15
  call itoa

  push $s1
  call puts  
*/

  call reboot
  add $2, %sp
  jmp .


#.include "../modules/real/putc.s"
.include "../modules/real/puts.s"
.include "../modules/real/itoa.s"
.include "../modules/real/reboot.s"

.align 2
 BOOT:


.data
  drive: .byte 0xBB
  BOOT_LOAD: .word 0x7C00
  s0: .string "Booting..."
  s1: .string "--------"
