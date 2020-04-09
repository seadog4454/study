.include "./define.s"
.include "./macro.s"

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
/*
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
*/

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


  push $.Lkernel_s0
  push $0x010F
  push $14
  push $0x19
  call draw_str
  add $0x10, %sp

  push $0x4
  push $63
  call draw_color_bar
  add $0x8, %sp

/*
  push $0x01
  push $0x4
  push $0x8
  call draw_pixel
  add $0xc, %sp

  push $0x01
  push $0x5
  push $0x9
  call draw_pixel
  add $0xc, %sp

  push $0x02
  push $0x6
  push $0xa
  call draw_pixel
  add $0xc, %sp

  push $0x02
  push $0x7
  push $0xb
  call draw_pixel
  add $0xc, %sp

  push $0x03
  push $0x8
  push $0xc
  call draw_pixel
  add $0xc, %sp
  
  push $0x03
  push $0x9
  push $0xd
  call draw_pixel
  add $0xc, %sp

  push $0x04
  push $0xa
  push $0xe
  call draw_pixel
  add $0xc, %sp

  push $0x04
  push $0xb
  push $0xf
  call draw_pixel
  add $0xc, %sp
  
  push $0x03
  push $0x4
  push $0xf
  call draw_pixel
  add $0xc, %sp

  push $0x03
  push $0x5
  push $0xe
  call draw_pixel
  add $0xc, %sp

  push $0x04
  push $0x6
  push $0xd
  call draw_pixel
  add $0xc, %sp

  push $0x04
  push $0x7
  push $0xc
  call draw_pixel
  add $0xc, %sp

  push $0x01
  push $0x8
  push $0xb
  call draw_pixel
  add $0xc, %sp

  push $0x01
  push $0x9
  push $0xa
  call draw_pixel
  add $0xc, %sp

  push $0x02
  push $0xa
  push $0x9
  call draw_pixel
  add $0xc, %sp

  push $0x02
  push $0xb
  push $0x8
  call draw_pixel
  add $0xc, %sp
*/
  push $0x0F
  push $0x0
  push $0x0 
  push $100
  push $100
  call draw_line
  add $0x14, %sp 

  push $0x3
  push $200
  push $200
  push $100
  push $100
  call draw_rect
  add $0x14, %sp
/*
  push $0x11223344
  pushf
  call $0x0008, $int_default
*/
  call init_int
  set_vect 0x00, $int_zero_div

  mov $0x0, %al
  div %al
/*
  push %eax
  push %edi
  mov %edi
*/

.Lkernel_10L:

  push $RTC_TIME
  call rtc_get_time
  add $0x4, %sp

  pushl (RTC_TIME)
  push $0x0700
  push $0x0
  push $72
  call draw_time
  add $0x10, %sp

  jmp .Lkernel_10L
  
  jmp .

.Lkernel_s0: .string "Hello, kernel!"

.align 4
FONT_ADR: .long 0x0
RTC_TIME: .long 0x0

.include "../modules/protect/vga.s"
.include "../modules/protect/draw_char.s"
.include "../modules/protect/draw_font.s"
.include "../modules/protect/draw_str.s"
.include "../modules/protect/draw_color_bar.s"
.include "../modules/protect/draw_pixel.s"
.include "../modules/protect/draw_line.s"
.include "../modules/protect/draw_rect.s"
.include "../modules/protect/itoa.s"
.include "../modules/protect/rtc.s"
.include "../modules/protect/draw_time.s"
.include "./modules/interrupt.s"

.fill KERNEL_SIZE - (. - kernel), 0x1, 0x0
