.include "./define.s"

.code32
.global kernel


kernel:
  
  # Get font addr. The addr is had in boot.s(where, the addr = BOOT_LOAD + SECT_SIZE).
  #push %ebx
  #push %ecx

  #mov $BOOT_LOAD, %ebx
  #mov $SECT_SIZE, %ecx
  #add %ecx, %ebx
  #mov %ebx, %esi
  #pop %ecx
  #pop %ebx
  
  mov $0x7E00, %esi

  movzxw (%esi), %eax
  movzxw 0x2(%esi), %ebx # segment
  shl $0x4, %eax # offset
  add %ebx, %eax
  mov %eax, (FONT_ADR)
  
  # Draw horizontal line(8bit).
  mov $0x7, %ah # set 1bit in RGB plane.
  mov $0x2, %al # map mask register
  mov $0x3C4, %dx # sequence control port
  out %ax, %dx
  
  movb $0xFF, (VRAM)
  
  mov $0x4, %ah
  out %ax, %dx

  movb $0xFF, (VRAM + 0x1)
  
  mov $0x2, %ah
  out %ax, %dx

  movb $0xFF, (VRAM + 0x2)
  
  mov $0x1, %ah
  out %ax, %dx

  movb $0xFF, (VRAM + 0x3)
/*
  # Draw horizontal line is traversed screen.
  
  mov $0x02, %ah
  out %ax, %dx

  lea (VRAM + 80), %edi
  mov $80, %ecx
  mov $0xFF, %al
  rep stosb


  # Draw char in the 3rd row.
  mov $0x41, %esi
  shl $0x4, %esi
  add (FONT_ADR), %esi
  
  mov $0x2, %edi
  shl $0x8, %edi
  #lea (%edi * 4 + %edi + VRAM), %edi
*/
  jmp .

.align 4
FONT_ADR: .int 0x0

.fill KERNEL_SIZE - (. - kernel), 0x1, 0x0
