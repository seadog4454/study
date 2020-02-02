memcpy:
  push %bp
  mov %sp, %bp
  
  push %cx
  push %si
  push %di

  cld
  mov (%bp + 8), %di
  mov (%bp + 12), %si
  mov (%bp + 16), %cx
  
  rep movsb

  pop %di
  pop %si
  pop %si


  mov %bp, %sp
  pop %bp
  
  ret
