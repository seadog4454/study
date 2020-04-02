/*
 *  draw_line(X0, Y0, X1, Y1, color)
 *  X0: start point of x
 *  Y0: start point of y
 *  X1: end point of x
 *  Y1: end point of y
 *  color:  drawing color
 *  return: void
 */

draw_line:
  push %ebp
  mov %esp, %ebp

  pushl $0
  pushl $0
  pushl $0
  pushl $0
  pushl $0
  pushl $0
  pushl $0

  push %eax
  push %ebx
  push %ecx
  push %edx
  push %esi
  push %edi

  mov 0x8(%ebp), %eax # X0
  mov 0x10(%ebp), %ebx # X1
  sub %eax, %ebx # X1 - X0
  jge .Ldraw_line_10F

  neg %ebx
  mov $-0x1, %esi
  jmp .Ldraw_line_10E

.Ldraw_line_10F:

  mov $0x1, %esi

.Ldraw_line_10E:
  
  mov 0xc(%ebp), %ecx # Y0
  mov 0x14(%ebp), %edx # Y1
  sub %ecx, %edx # Y1 - Y0
  jge .Ldraw_line_20F

  neg %edx
  mov $-0x1, %edi
  jmp .Ldraw_line_20E

.Ldraw_line_20F:
  
  mov $0x1, %edi


.Ldraw_line_20E:

  mov %eax, -0x8(%ebp)
  mov %ebx, -0xc(%ebp)
  mov %esi, -0x10(%ebp)

  mov %ecx, -0x14(%ebp)
  mov %edx, -0x18(%ebp)
  mov %edi, -0x1c(%ebp)

  cmp %edx, %ebx
  jg .Ldraw_line_22F

  lea -0x14(%ebp), %esi
  lea -0x8(%ebp), %edi

  jmp .Ldraw_line_22E

.Ldraw_line_22F:

  lea -0x8(%ebp), %esi
  lea -0x14(%ebp), %edi


.Ldraw_line_22E:
  mov -0x4(%esi), %ecx
  cmp $0x0, %ecx
  jnz .Ldraw_line_30E
  mov $0x1, %ecx


.Ldraw_line_30E:
  

.Ldraw_line_50L:
  
  pushl 0x18(%ebp)
  pushl -0x14(%ebp)
  pushl -0x8(%ebp)
  call draw_pixel
  add $0xc, %sp

  mov -0x8(%esi), %eax
  add %eax, (%esi)

  mov -0x4(%ebp), %eax
  add -0x4(%edi), %eax
  mov -0x4(%esi), %ebx

  cmp %ebx, %eax
  jl .Ldraw_line_52E
  sub %ebx, %eax

  mov -0x8(%edi), %ebx
  add %ebx, (%edi)

.Ldraw_line_52E:
  mov %eax, -0x4(%ebp)
  loop .Ldraw_line_50L


.Ldraw_line_50E:
  
  pop %edi
  pop %esi
  pop %edx
  pop %ecx
  pop %ebx
  pop %eax

  mov %ebp, %esp
  pop %ebp

  ret

  

  
