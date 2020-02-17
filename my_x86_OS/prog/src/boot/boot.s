.code16

.section .bss
	.space drive.size

#.section .data
#.Lboot_drive:
#  .struct 0
#.Lboot_drive.no:
#  .struct .Lboot_drive.no + 2
#.Lboot_drive.cyln:
#  .struct .Lboot_drive.cyln + 2
#.Lboot_drive.head:
#  .struct .Lboot_drive.head + 2
#.Lboot_drive.sect:


.section .text
.global _start

_start:
  jmp ipl

  # BPB(BIOS Prameter Block)  
  .fill 90 - (. - _start), 0x1, 0x0

  # IPL(Initial Program Loader)
ipl:
  cli
  mov $0x0000, %ax
  mov %ax, %ds
  mov %ax, %es
  mov %ax, %ss
  
  mov (.Lboot_BOOT_LOAD), %sp
  sti
  
  push %bx
  mov $drive.size, %bx
  mov %dl, drive.no(%bx)
  pop %bx
  push $.Lboot_s0
  call puts
  add $2, %sp


.include "../modules/real/putc.s"
.include "../modules/real/puts.s"
#.include "../modules/real/itoa.s"
.include "../modules/real/reboot.s"
.include "../modules/real/read_chs.s"

 /* 
  mov $.Lboot_BOOT_SECT, %bx
  mov (%bx), %bx
  sub 0x1, %bx
  mov %bx, bx
  #push %cx
  #push %bx
  #push $.Lboot_drive
  #call read_chs
  cmp %bx, %ax
  jz .Lboot_10E
  push $.Lboot_e0
  call puts
  add $2, %sp
  call reboot
.Lboot_10E:
  jmp stage_2
*/

.section .text

.Lboot_s0: .string "Booting...\r\n"
.Lboot_s1: .string "--------\r\n"
.Lboot_e0: .string "Error:sector read"
.Lboot_BOOT_LOAD: .word 0x7C00
.Lboot_BOOT_SIZE: .word (1024 * 8)
.Lboot_SECT_SIZE: .word 512
.Lboot_BOOT_SECT: .word 16 #(.Lboot_BOOT_SIZE / .Lboot_SECT_SIZE)


/* write boot signature in 0x200 */

.Lboot_boot_sig: .fill 0x1fe - (. - _start), 0x1, 0x0
.Lboot_BOOT_SIGNATURE: .word 0xAA55

stage_2:
  push $.Lboot_s2
  call puts
  add $0x2, %sp
  jmp .

.Lboot_s2: .string "2nd stage...\r\n"


