draw_rotation_bar:
  push %eax

  mov (TIMER_COUNT), %eax
  shr $0x4, %eax
  cmp (.index), %eax
  je 10f

  mov %eax, (.index)
  and $0x03, %eax
  mov .table(%eax), %al

  push %eax
  push $0x000F
  push $0x1d
  push $0x0
  call draw_char
  add $0x10, %sp

10:
  
  pop %eax
  ret

.align 0x4
.index: .long 0x0
.table: .ascii "|/-¥"
