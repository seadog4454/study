.code16

putc:
  push %bp
  mov %sp, %bp

  push %ax
  push %bx

  
  # mov $0x41, %al
  # mov $0x0E, %ah
  # mov $0x0000, %bx
  # int $0x10


  mov 0x4(%bp), %al
  mov $0x0E, %ah
  mov $0x0000, %bx
  int $0x10

  pop %bx
  pop %ax

  mov %bp, %sp
  pop %bp

  ret
