task_1:
  push $.s0
  push $0x07
  push $0x0
  push $63
  call draw_str
  add $0x10, %sp

  iret

.s0: .string "Task-1"
