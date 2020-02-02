.code16

puts:
  push %bp
  mov %sp, %bp

  push %ax
  push %bx
  push %si #arg1: pointer of strings

  mov 0x4(%bp), %si

  mov $0x0E, %ah # output one char
  mov $0x0000, %bx
  cld # DF = 0

  
/*
for(i=0, AL != null; AL++){
  int 0x10 # put AL
}
*/


.loop1:
  lodsb # AL = *SI++
  cmp $0, %al
  je .L1
  
  int $0x10
  jmp .loop1

.L1:

  pop %si
  pop %bx
  pop %ax

  mov %bp, %sp
  pop %bp

  ret
 
