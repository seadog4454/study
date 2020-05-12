/*
 *  draw_str(col, row, color, p)
 *  arguments:
 *    col
 *    row:
 *    color: drawing color
 *    str's addr
 */

draw_str:
  push %ebp
  mov %esp, %ebp

  push %eax
  push %ebx
  push %ecx
  push %edx
  push %esi

  mov 0x8(%ebp), %ecx
  mov 0xc(%ebp), %edx
  movzxw 0x10(%ebp), %ebx
  mov 0x14(%ebp), %esi

  cld
.Ldraw_str_10L:

  lodsb
  cmp $0x0, %al
  je .Ldraw_str_10E

.ifdef USE_SYSTEM_CALL
  int $0x81
.else
  push %eax
  push %ebx
  push %edx
  push %ecx
  call draw_char
  add $0x10, %sp
.endif


  inc %ecx
  cmp $80, %ecx
  jl .Ldraw_str_12E
  mov $0, %ecx
  inc %edx
  cmp $30, %edx
  jl .Ldraw_str_12E
  mov $0, %edx

.Ldraw_str_12E:
  jmp .Ldraw_str_10L

.Ldraw_str_10E:

  pop %esi
  pop %edx
  pop %ecx
  pop %ebx
  pop %eax

  mov %ebp, %esp
  pop %ebp

  ret

