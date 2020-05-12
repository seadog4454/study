int_timer:
  pusha
  push %ds
  push %es
  
  mov $0x0010, %ax
  mov %ax, %ds
  mov %ax, %es

  incl (TIMER_COUNT)

  outp $0x20, $0x20

  str %ax
  cmp $SS_TASK_0, %ax
  je 11f

  jmp $SS_TASK_0, $0x0
  jmp 10f

11:
  jmp $SS_TASK_1, $0x0
  jmp 10f

10:

  pop %es
  pop %ds
  popa

  iret

.align 0x4
TIMER_COUNT: .long 0x0
