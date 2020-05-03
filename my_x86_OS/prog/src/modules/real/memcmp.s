.code16
.section .text

memcmp:
  push %bp
  mov %sp. %bp

  push %bx
  push %cx
  push %dx
  push %si
  push %di

  cld
  mov (%bp+4), %si
  mov (%bp+6), %di
  mov (%bp+8), %cx

  repe cmpsb ; Find mismatched bytes in ES: [(E) DI] and DS: [(E) SI]
  jnz .10F
  mov $0, %ax
  jmp .10E
.10F:
  mov $-1, %ax
.10E:
  
  pop %di
  pop %si
  pop %cx
  pop %bx

  mov %bp, %sp
  pop %bp

  ret

