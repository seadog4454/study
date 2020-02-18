.code16
.section .text

memcpy:
  push %bp
  mov %sp, %bp
  
  push %cx
  push %si
  push %di

  cld
  mov (%bp + 4), %di
  mov (%bp + 6), %si
  mov (%bp + 8), %cx
  
  rep movsb

  pop %di
  pop %si
  pop %si


  mov %bp, %sp
  pop %bp
  
  ret
