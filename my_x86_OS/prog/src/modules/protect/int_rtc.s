/*
 *  rtc_int(bit)
 */

rtc_int_en:
  push %ebp
  mov %esp, %ebp

  push %eax

  outp $0x70, $0x0B

  in $0x71, %al
  or 0x8(%ebp), %al
  out %al, $0x71

  pop %eax

  mov %ebp, %esp
  pop %ebp
  ret

int_rtc:
  pusha
  push %ds
  push %es

  mov $0x0010, %ax
  mov %ax, %ds
  mov %ax, %es

  push $RTC_TIME
  call rtc_get_time
  add $0x4, %sp

  outp $0x70, $0x0C
  in $0x71, %al

  # EOI command
  outp $0xA0, $0x20
  outp $0x20, $0x20

  pop %es
  pop %ds
  popa

  iret
