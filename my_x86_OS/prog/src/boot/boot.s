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
drive_tmp: .space drive.size

#.include "../modules/real/putc.s"
.include "../modules/real/puts.s"
.include "../modules/real/reboot.s"
.include "../modules/real/read_chs.s"

.section .text
/* write boot signature in 0x200 */

.Lboot_boot_sig: .fill 0x1fe - (. - _start), 0x1, 0x0
.Lboot_BOOT_SIGNATURE: .word 0xAA55

/*
 * Can't refer to a common label in real mode and protected mode.
 * Because these are assembled separately.
 * So, An absolute address is required for reference in both modes.
 * In addition, the address have to be specified in a location we understand easyly.
 * In this program, the address will be located after signature, 0xAA55.
 */
FONT:
FONT.seg: .word 0x0
FONT.off: .word 0x0
ACPI_DATA:
ACPI_DATA.adr: .long 0x0
ACPI_DATA.len: .long 0x0

.include "../modules/real/itoa.s"
.include "../modules/real/get_drive_param.s"
.include "../modules/real/get_font_adr.s"
.include "../modules/real/get_mem_info.s"
.include "../modules/real/kbc.s"


stage_2:
  push $.Lboot_s2
  call puts
  add $0x2, %sp

  push $drive_tmp
  call get_drive_param
  add $2, %sp
  cmp $0, %ax
  jne .Lboot_5E
  
  call puts
  add $2, %sp
  call reboot

.Lboot_5E:
  push $.Lboot_test
  call puts
  add $2, %sp

  movw $drive_tmp, %bx
  
  mov drive.no(%bx), %ax
  push $0b0100
  push $16
  push $2
  push $.Lboot_p1
  push %ax
  call itoa
  add $0xa, %sp


  mov drive.cyln.low(%bx), %ax
  push $0b0100
  push $16
  push $4
  push $.Lboot_p2
  push %ax
  call itoa
  add $0xa, %sp


  mov drive.head(%bx), %ax
  push $0b0100
  push $16
  push $2
  push $.Lboot_p3
  push %ax
  call itoa
  add $0xa, %sp

  mov drive.sect(%bx), %ax
  push $0b0100
  push $16
  push $2
  push $.Lboot_p4
  push %ax
  call itoa
  add $0xa, %sp

  push $.Lboot_s3
  call puts
  add $0x2, %sp

  jmp stage_3rd

.Lboot_s2: .string "2nd stage...\r\n"
.Lboot_e1: .string "Can't get drive parameter." 
.Lboot_s3: .ascii " Drive:0x"
.Lboot_p1: .ascii "  , C:0x"
.Lboot_p2: .ascii "    , H:0x"
.Lboot_p3: .ascii "  , S:0x"
.Lboot_p4: .string "  \r\n"
.Lboot_test: .string "test\r\n"



stage_3rd:
  push $.Lboot_3rd_s0
  call puts
  add $2, %sp

  push $FONT
  call get_font_adr
  add $2, %sp

  push $0b0100
  push $16
  push $4
  push $.Lboot_3rd_p1
  pushw (FONT.seg)
  call itoa
  add $0xa, %sp

  push $0b0100
  push $16
  push $4
  push $.Lboot_3rd_p2
  pushw (FONT.off)
  call itoa
  add $0xa, %sp

  push $.Lboot_3rd_s1
  call puts
  add $2, %sp

  call get_mem_info

  mov (ACPI_DATA.adr), %eax
  cmp $0, %eax
  je .Lboot_3rd_10E

  push $0b0100
  push $0x10
  push $0x4
  push $.Lboot_3rd_p4
  push %ax
  call itoa
  add $0xa, %sp

  shr $0x10, %eax
 
  push $0b0100
  push $0x10
  push $0x4
  push $.Lboot_3rd_p3
  push %ax
  call itoa
  add $0xa, %sp


  push $.Lboot_3rd_s2
  call puts
  add $2, %sp

.Lboot_3rd_10E:

  jmp stage_4


.Lboot_3rd_s0: .string "3rd stage...\n\r"
.Lboot_3rd_s1: .ascii " Font address="
.Lboot_3rd_p1: .ascii "ZZZZ:"
.Lboot_3rd_p2: .string "ZZZZ\n\r"
.string "\n\r"

.Lboot_3rd_s2: .ascii " ACPI data="
.Lboot_3rd_p3: .ascii "ZZZZ"
.Lboot_3rd_p4: .string "ZZZZ\r\n"



stage_4:

  push $.Lstage_4_s0
  call puts
  add $0x2, %sp

  cli
  
  push $0xAD # invalidate keyboard
  call KBC_Cmd_Write
  add $0x2, %sp

  push $0xD0 # setting: read value of output port
  call KBC_Cmd_Write
  add $0x2, %sp

  push $.Lstage_4_key # read value of output port
  call KBC_Data_Read
  add $0x2, %sp

  mov (.Lstage_4_key), %bl 
  or $0x2, %bl # activate A20 gate, A20 gate has bit1 of output port.

  push $0xD1 # setting: write value to output port
  call KBC_Cmd_Write
  add $0x2, %sp

  push %bx # write value to output port
  call KBC_Data_Write
  add $0x2, %sp

  push $0xAE # activate keyboard
  call KBC_Cmd_Write
  add $0x2, %sp

  sti
 
  push $.Lstage_4_s1
  call puts
  add $0x2, %sp
  
  jmp .

.Lstage_4_key: .word 0x0
.Lstage_4_s0: .string "4th stage...\n\r"
.Lstage_4_s1: .string "A20 Gate Enabled.\n\r"


.fill 0x2000 - (. - _start), 0x1, 0x0 # padding, 0x2000 = BOOT_SIZE

