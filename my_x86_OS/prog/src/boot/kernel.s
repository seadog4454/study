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
  
  mov $(BOOT_LOAD + SECT_SIZE), %esi
  movzxw (%esi), %eax
  movzxw 0x2(%esi), %ebx # segment
  shl $0x4, %eax # offset
  add %ebx, %eax
  mov %eax, (FONT_ADR)

  push $0x41
  push $0x010F
  push $0x0
  push $0x0
  call draw_char
  add $0x10, %sp


  push $0x42
  push $0x010F
  push $0x0
  push $0x1
  call draw_char
  add $0x10, %sp

  push $0x43
  push $0x010F
  push $0x0
  push $0x2
  call draw_char
  add $0x10, %sp


  push $0x31
  push $0x010F
  push $0x0
  push $0x0
  call draw_char
  add $0x10, %sp


  push $0x32
  push $0x010F
  push $0x0
  push $0x1
  call draw_char
  add $0x10, %sp


  push $0x33
  push $0x010F
  push $0x0
  push $0x2
  call draw_char
  add $0x10, %sp

/*  
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

  # Draw horizontal line is traversed screen.
  
  mov $0x02, %ah
  out %ax, %dx

  lea (VRAM + 80), %edi
  mov $80, %ecx
  mov $0xFF, %al
  rep stosb

  # Draw 8 bit's rectangle in the 2nd row.
  
  # add offset 1280(oen line)
  mov $0x1, %edi # number of the lines
  shl $0x8, %edi # %edi * 256
  lea VRAM(%edi, %edi, 0x4), %edi

  # x = 640, 80 * 8 bits = 640
  movw $0xFF, (80*0)(%edi)
  movw $0xFF, (80*1)(%edi)
  movw $0xFF, (80*2)(%edi)
  movw $0xFF, (80*3)(%edi)
  movw $0xFF, (80*4)(%edi)
  movw $0xFF, (80*5)(%edi)
  movw $0xFF, (80*6)(%edi)
  movw $0xFF, (80*7)(%edi)
    

  # Draw char in the 3rd row.
  mov $0x41, %esi
  shl $0x4, %esi
  add (FONT_ADR), %esi

  
  # add offset 1280(oen line)
  mov $0x2, %edi # number of the lines
  shl $0x8, %edi # %edi * 256
  lea VRAM(%edi, %edi, 0x4), %edi

  mov $0x10, %ecx
.Lkernel_10L:

  movsb
  add $(80 - 1), %edi
  loop .Lkernel_10L
*/

  push $13
  push $63
  call draw_font
  add $0x8, %sp 

  jmp .


.align 4
FONT_ADR: .long 0x0

.include "../modules/protect/vga.s"
.include "../modules/protect/draw_char.s"
.include "../modules/protect/draw_font.s"

.fill KERNEL_SIZE - (. - kernel), 0x1, 0x0
