.code16

.section .text
.global _start

_start:
  jmp ipl

  # BPB(BIOS Prameter Block)  
  .fill 90 - (. - _start), 0x1, 0x90

  # IPL(Initial Program Loader)
ipl:
  cli
  mov $0x0000, %ax
  mov %ax, %ds
  mov %ax, %es
  mov %ax, %ss 
  mov (.Lboot_BOOT_LOAD), %sp
  mov $0x7C00, %sp
	sti

	movw $drive_tmp, %bx
	movw $0x0, drive.no(%bx)
	movw $0x0, drive.cyln.low(%bx)
	movw $0x0, drive.head(%bx)
	movw $0x2, drive.sect(%bx)


	mov %dl, (drive_tmp)
	push $.Lboot_s0
  call puts
  add $0x2, %sp

	mov (.Lboot_BOOT_LOAD), %ax
	mov (.Lboot_SECT_SIZE), %cx
  mov (.Lboot_BOOT_SECT), %bx
	sub $0x1, %bx
	add %ax, %cx



	push %cx
  push %bx
  push $drive_tmp
	call read_chs
  add $6, %sp
	cmp %bx, %ax
  jz .Lboot_10E
  push $.Lboot_e0
  call puts
  add $2, %sp
  call reboot
.Lboot_10E:
  jmp stage_2



.Lboot_s0: .string "Booting...\n\r"
.Lboot_e0: .string "Error:sector read"
.Lboot_BOOT_LOAD: .word 0x7C00
.Lboot_BOOT_SIZE: .word 0x2000 #(1024 * 8)
.Lboot_SECT_SIZE: .word 512
.Lboot_BOOT_SECT: .word 16 #(.Lboot_BOOT_SIZE / .Lboot_SECT_SIZE)


.align 2
drive_tmp: .space 0x8

#.include "../modules/real/putc.s"
.include "../modules/real/puts.s"
#.include "../modules/real/itoa.s"
.include "../modules/real/reboot.s"
.include "../modules/real/read_chs.s"

.section .text
/* write boot signature in 0x200 */

.Lboot_boot_sig: .fill 0x1fe - (. - _start), 0x1, 0x0
.Lboot_BOOT_SIGNATURE: .word 0xAA55

stage_2:
  push $.Lboot_s2
  call puts
  add $0x2, %sp
  jmp .

.Lboot_s2: .string "2nd stage...\r\n"

.fill 0x2000 - (. - _start), 0x1, 0x0 # padding
