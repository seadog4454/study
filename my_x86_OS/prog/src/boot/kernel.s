.include "./define.s"
.include "./macro.s"

.code32
.global kernel


kernel:
  
  
  mov $(BOOT_LOAD + SECT_SIZE), %esi
  movzxw (%esi), %eax
  movzxw 0x2(%esi), %ebx # segment
  shl $0x4, %eax # offset
  add %ebx, %eax
  mov %eax, (FONT_ADR)


  set_desc1 $GDT.tss_0, $TSS_0
  set_desc1 $GDT.tss_1, $TSS_1
  set_desc2 $GDT.ldt, $LDT, $LDT_LIMIT

  lgdt (GDTR)

  mov $SP_TASK_0, %esp

  mov $SS_TASK_0, %ax
  ltr %ax

  call init_int
  call init_pic

  set_vect 0x00, $int_zero_div
  set_vect 0x20, $int_timer
  set_vect 0x21, $int_keyboard
  set_vect 0x28, $int_rtc

  push $0x10
  call rtc_int_en
  add $0x4, %esp
  call int_en_timer0

  outp $0x21, $0b11111000# enable slavePIC/KBC/timer
  #outp $0x21, $0b11111011
  #outp $0x21, $0b11111001
  outp $0xA1, $0b11111110 # enable RTC

  sti

  
  push $13
  push $63
  call draw_font
  add $0x8, %sp 



  push $0x4
  push $63
  call draw_color_bar
  add $0x8, %sp


  push $.Lkernel_s0
  push $0x010F
  push $14
  push $0x19
  call draw_str
  add $0x10, %sp

  #call SS_TASK_1, $0x0
  call $0x28, $0x0

.Lkernel_10L:


  mov (RTC_TIME), %eax

  push %eax
  push $0x0700
  push $0x0
  push $72
  call draw_time
  add $0x10, %sp

  call draw_rotation_bar

  push $.int_key
  push $_KEY_BUFF
  call ring_rd
  add $0x8, %sp
  cmp $0x0, %eax
  je .Lkernel_10E

  push $_KEY_BUFF
  push $29
  push $2
  call draw_key
  add $0xc, %sp

.Lkernel_10E:
  jmp .Lkernel_10L 

.Lkernel_s0: .string "Hello, kernel!"

.align 4
FONT_ADR: .long 0x0
RTC_TIME: .long 0x0
.int_key: .long 0x0


.include "descriptor.s"
.include "modules/int_timer.s"
.include "tasks/task_1.s"
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
#.include "./modules/interrupt.s"
.include "../modules/protect/pic.s"
.include "../modules/protect/int_rtc.s"
.include "../modules/protect/interrupt.s"
.include "../modules/protect/int_keyboard.s"
.include "../modules/protect/ring_buff.s"
.include "../modules/protect/timer.s"
.include "../modules/protect/draw_rotation_bar.s"

.fill KERNEL_SIZE - (. - kernel), 0x1, 0x0
