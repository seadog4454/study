call_gate:
  push %ebp
  mov %esp, %ebp

  pusha
  push %ds
  push %es

  mov $0x0010, %ax
  mov %ax, %ds
  mov %ax, %es

  mov 0xc(%ebp), %eax
  mov 0x10(%ebp), %ebx
  mov 0x14(%ebp), %ecx
  mov 0x18(%ebp), %edx

  push %edx
  push %ecx
  push %ebx
  push %eax
  call draw_str
  add $0x10, %sp

  pop %es
  pop %ds
  popa

  mov %ebp, %esp
  pop %ebp

  
 retf $0x10

