.code16
.text
.global _start



_start:
  jmp ipl

  # BPB
  
  #.org 90 - (. - _start), 0x90

  # IPL
 ipl:
  /*
  cli
  mov $0x0000, %ax
  mov %ax, %ds
  mov %ax, %es
  mov %ax, %ss
  # mov (BOOT_LOAD), %sp
  mov $0x7C00, %sp
  sti
  mov %dl, (boot_drive)
  */

  # push $0x41
  # call putc
  # add $2, %sp
  
  /*
  push $s0
  call puts
  add $2, %sp
  */
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
  
# read 512 bytes : read sector
  mov $0x02, %ah # instruct read
  mov $0x1, %al # number of reading sector
  mov $0x0002, %cx # cylinder/sector
  mov $0x00, %dh # head position
  # mov (boot_drive), %dl # drive number
  mov $0x80, %dl
  mov $0x7E00, %bx # offset
  int $0x13 # bios call : read sector
  jnc .Lboot1
  push $e0
  call puts
  add $0x2, %sp
  call reboot
.Lboot1:
  jmp stage_2



s0: .string "Booting...\r\n"
;s1: .string "--------\r\n"
e0: .string "Error:sector read"
BOOT_LOAD: .word 0x7C00

#.align 2
# BOOT:
# drive: .byte 0xBB
#boot_drive: .word 0x0000

#.include "../modules/real/putc.s"
.include "../modules/real/puts.s"
#.include "../modules/real/itoa.s"
.include "../modules/real/reboot.s"


stage_2:
  push $s2
  call puts
  add $0x2, %sp
  jmp .

s2: .string "2nd stage...\r\n"

