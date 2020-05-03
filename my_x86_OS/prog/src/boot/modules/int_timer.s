int_timer:
  pusha
  push %ds
  push %es
  
  mov $0x0010, %ax
  mov %ax, %ds
  mov %ax, %es

  incl (TIMER_COUNT)

  outp $0x20, $0x20

  pop %es
  pop %ds
  popa

  iret

.align 0x4
TIMER_COUNT: .long 0x0
