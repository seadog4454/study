int_keyboard:
  pusha
  push %ds
  push %es

  mov $0x0010, %ax
  mov %ax, %ds
  mov %ax, %es

  in $0x60, %al

  push %eax
  push $_KEY_BUFF
  call ring_wr
  add $0x8, %sp

  outp $0x20, $0x20

  pop %es
  pop %ds
  popa

  iret

.align 4
_KEY_BUFF: .fill ring_buff.size, 0x1, 0x0
