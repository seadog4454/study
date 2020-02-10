.code16
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

.Lboot_s0: .string "Booting...\r\n"
.Lboot_s1: .string "--------\r\n"
.Lboot_e0: .string "Error:sector read"
.Lboot_BOOT_LOAD: .word 0x7C00


.include "../modules/real/putc.s"
.include "../modules/real/puts.s"
.include "../modules/real/itoa.s"
.include "../modules/real/reboot.s"


/* write boot signature in 0x200 */
.Lboot_boot_sig: .fill 0x1fe - (. - _start), 0x1, 0x0
.Lboot_BOOT_SIGNATURE: .word 0xAA55

stage_2:
  push $.Lboot_s2
  call puts
  add $0x2, %sp
  jmp .

.Lboot_s2: .string "2nd stage...\r\n"

