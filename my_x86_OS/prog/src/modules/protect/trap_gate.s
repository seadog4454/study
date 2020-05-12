trap_gate_81:
  push %eax
  push %ebx
  push %edx
  push %ecx
  call draw_char
  add $0x10, %sp

  iret

trap_gate_82:
  push %ebx
  push %edx
  push %ecx
  call draw_pixel
  add $0xc, %sp

  iret
