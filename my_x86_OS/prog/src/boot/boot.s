.include "./define.s"

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
  #mov (.Lboot_BOOT_LOAD, %sp
	mov $BOOT_LOAD, %sp

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

	mov $BOOT_LOAD, %ax
	mov $SECT_SIZE, %cx
  mov $BOOT_SECT, %bx
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
#.Lboot_BOOT_LOAD: .word 0x7C00
#.Lboot_BOOT_SIZE: .word 0x2000 #(1024 * 8)
#.Lboot_SECT_SIZE: .word 512
#.Lboot_BOOT_SECT: .word 0x10 #(.Lboot_BOOT_SIZE / .Lboot_SECT_SIZE)
#.Lboot_BOOT_END: .word 0x9C00
#.Lboot_KERNEL_SECT: .word 0x10 #(.Lboot_KERNEL_SIZE / .Lboot_SECT_SIZE)

.align 2
drive_tmp: .space drive.size

#.include "../modules/real/putc.s"
.include "../modules/real/puts.s"
.include "../modules/real/reboot.s"
.include "../modules/real/read_chs.s"

.section .text
/* write boot signature in 0x200 */

.Lboot_boot_sig: .fill 0x1fe - (. - _start), 0x1, 0x0
BOOT_SIGNATURE: .word 0xAA55

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
.include "../modules/real/read_lba.s"
.include "../modules/real/lba_chs.s"

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

  push $.Lstage_4_s2
  call puts
  add $0x2, %sp

  mov $0x0, %bx
.Lstage_4_10L:

  mov $0x00, %ah
  int $0x16

  cmp 0x31, %al
  jb .Lstage_4_10E
  
  cmp $0x33, %al
  ja .Lstage_4_10E

  mov %al, %cl
  dec %cl
  and $0x03, %cl
  mov $0x0001, %ax
  shl %cl, %ax
  xor %ax, %bx

  cli

  push $0xAD
  call KBC_Cmd_Write
  add $0x2, %sp

  push $0xED
  call KBC_Data_Write
  add $0x2, %sp

  push $.Lstage_4_key
  call KBC_Data_Read
  add $0x2, %sp

  cmpb $0xFA, (.Lstage_4_key)
  jne .Lstage_4_11F

  push %bx
  call KBC_Data_Write
  add $0x2, %sp

  jmp .Lstage_4_11E
.Lstage_4_11F:
  
  push $0b0100
  push $0x10
  push $0x2
  push $.Lstage_4_e1
  pushw (.Lstage_4_key)
  call itoa
  add $0xA, %sp

  push $.Lstage_4_e0
  call puts
  add $0x2, %sp

.Lstage_4_11E:
    push $0xAE
    call KBC_Cmd_Write
    add $0x2, %sp


  sti
  
  jmp .Lstage_4_10L

.Lstage_4_10E:

  push $.Lstage_4_s3
  call puts
  add $0x2, %sp

  jmp stage5

.Lstage_4_key: .word 0x0
.Lstage_4_s0: .string "4th stage...\n\r"
.Lstage_4_s1: .string "A20 Gate Enabled.\n\r"
.Lstage_4_s2: .string "Keyboard LED Test..."
.Lstage_4_s3: .string "(done)\n\r"

.Lstage_4_e0: .ascii "["
.Lstage_4_e1: .string "ZZ]"

stage5:
	push $.Lstage5_s0
	call puts
	add $0x2, %sp
	
	push $BOOT_END
	push $KERNEL_SECT
	push $BOOT_SECT
	push $drive_tmp
	call read_lba
  cmp $KERNEL_SECT, %ax
	jz .Lstage5_10E
	push $.Lstage5_e0
	call puts
	add $0x2, %sp
	call reboot
.Lstage5_10E:
	jmp stage6

.Lstage5_s0: .string "5th stage...\n\r"
.Lstage5_e0: .string "Failure load kernel...\n\r"


stage6:
  push $.Lstage6_s0
  call puts
  add $0x2, %sp
.Lstage6_10L:
  
  mov $0x0, %ah
  int $0x16
  cmp $0x20, %al
  jne .Lstage6_10L

  mov $0x0012, %ax # VGA 640 * 480
  int $0x10

  jmp stage7

.Lstage6_s0: .ascii "6th stage...\n\r\n\r"
.string "[Push SPACE key to protect mode...]\n\r"



.align 4

GDT: .quad 0x0000000000000000
.cs: .quad 0x00CF9A000000FFFF
.ds: .quad 0x00CF92000000FFFF
.gdt_end:

.set SEL_CODE, .cs - GDT
.set SEL_DATA, .ds - GDT

GDTR: .word .gdt_end - GDT - 1 
      .long GDT

IDTR: .word 0x0
      .long 0x0




stage7:
  cli

  lgdt (GDTR)
  lidt (IDTR)
  
  mov %cr0, %eax
  or $0x1, %ax
  mov %eax, %cr0

  jmp . + 2
  nop

.code32

.byte 0x66
jmp $SEL_CODE, $CODE_32


CODE_32:
  mov $SEL_DATA, %ax
  mov %ax, %ds
  mov %ax, %es
  mov %ax, %fs
  mov %ax, %gs
  mov %ax, %ss
  
  mov $KERNEL_SIZE/4, %ecx
  mov $BOOT_END, %esi
  mov $KERNEL_LOAD, %edi
  cld
  rep movsd
  
  jmp KERNEL_LOAD

.fill BOOT_SIZE - (. - _start), 0x1, 0x0 # padding, 0x2000 = BOOT_SIZE
