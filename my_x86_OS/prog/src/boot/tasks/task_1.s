task_1:
/*
  push $.s0
  push $0x07
  push $0x0
  push $63
  call draw_str
  add $0x10, %sp
*/
 10:

  push $.s0
  push $0x07
  push $0x0
  push $63
  call $SS_GATE_0, $0x0
/*
  mov (RTC_TIME), %eax
  push %eax
  push $0x700
  push $0x0
  push $0x48
  call draw_time
  add $0x10, %sp

  jmp $SS_TASK_0, $0x0
*/  
  jmp 10b

.s0: .string "Task-1"
