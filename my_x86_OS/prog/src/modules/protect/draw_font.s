/*
 *  draw_font(col, row)
 *  arguments:
 *    col:
 *    row
 *  return: null
 */

draw_font:
  push %ebp
  mov %esp, %ebp

  push %eax
  push %ebx
  push %ecx
  push %edx
  push %esi
  push %edi

  mov 0x8(%ebp), %esi # col
  mov 0xc(%ebp), %edi # row

  mov $0x0, %ecx
.Ldraw_font_10L:  
  cmp $0x100, %ecx
  jae .Ldraw_font_10E

  mov %ecx, %eax
  and $0x0F, %eax
  add %esi, %eax

  mov %ecx, %ebx
  shr $0x4, %ebx
  add %edi, %ebx

  push %ecx
  push $0x07
  push %ebx
  push %eax
  call draw_char
  add $0x10, %sp

  inc %ecx
  jmp .Ldraw_font_10L
.Ldraw_font_10E:

  pop %edi
  pop %esi
  pop %edx
  pop %ecx
  pop %ebx
  pop %eax

  mov %ebp, %esp
  pop %ebp

  ret
