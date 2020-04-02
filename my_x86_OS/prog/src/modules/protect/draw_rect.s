/*
 *  draw_rect(X0, Y0, X1, Y1, color)
 *  arguments:
 *    X0: starting x
 *    Y0: starting y
 *    X1: end of x
 *    Y1: end of y
 *    color: drawing color
 *  return: void
 */

 draw_rect:
  push %ebp
  mov %esp, %ebp

  push %eax
  push %ebx
  push %ecx
  push %edx
  push %esi

  mov 0x8(%ebp), %eax # X0
  mov 0xc(%ebp), %ebx # Y0
  mov 0x10(%ebp), %ecx # X1
  mov 0x14(%ebp), %edx # Y1
  mov 0x18(%ebp), %esi # color

  cmp %ecx, %eax
  jl .Ldraw_rect_10E
  xchg %ecx, %eax

.Ldraw_rect_10E:
  
  cmp %edx, %ebx
  jl .Ldraw_rect_20E
  xchg %edx, %ebx

.Ldraw_rect_20E:

  push %esi
  push %ebx
  push %ecx
  push %ebx
  push %eax
  call draw_line
  add $0x14, %sp

  push %esi
  push %edx
  push %eax
  push %ebx
  push %eax
  call draw_line
  add $0x14, %sp

  dec %edx
  push %esi
  push %edx
  push %ecx
  push %edx
  push %eax
  call draw_line
  add $0x14, %sp
  inc %edx

  dec %ecx
  push %esi
  push %edx
  push %ecx
  push %ebx
  push %ecx
  call draw_line
  add $0x14, %sp

  pop %esi
  pop %edx
  pop %ecx
  pop %ebx
  pop %eax

  mov %ebp, %esp
  pop %ebp

  ret
