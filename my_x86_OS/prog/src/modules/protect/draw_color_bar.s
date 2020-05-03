/*
 *  draw_color_bar(row, col)
 *  arguments:
 *    row:
 *    col:
 *  reuturn: void
 */

draw_color_bar:
  push %ebp
  mov %esp, %ebp

  push %eax
  push %ebx
  push %ecx
  push %edx
  push %esi
  push %edi

  mov 0x8(%ebp), %esi #row
  mov 0xc(%ebp), %edi #col

  mov $0x0, %ecx
.Ldraw_color_bar_10L:
  cmp $0x10, %ecx
  jae .Ldraw_color_bar_10E

  mov %ecx, %eax
  and $0x01, %eax
  shl $0x3, %eax
  add %esi, %eax

  mov %ecx, %ebx
  shr $0x1, %ebx
  add %edi, %ebx

  mov %ecx, %edx
  shl $0x1, %edx
  mov .Ldraw_color_bar_t0(%edx), %edx

  push $.Ldraw_color_bar_s0
  push %edx
  push %ebx
  push %eax
  call draw_str
  add $0x10, %sp

  inc %ecx
  jmp .Ldraw_color_bar_10L

.Ldraw_color_bar_10E:
  
  pop %edi
  pop %esi
  pop %edx
  pop %ecx
  pop %ebx
  pop %eax

  mov %ebp, %esp
  pop %ebp

  ret

.Ldraw_color_bar_s0: .string "        "

.Ldraw_color_bar_t0: .word 0x0000, 0x0800 
.word 0x0100, 0x0900
.word 0x0200, 0x0A00
.word 0x0300, 0x0B00
.word 0x0400, 0x0C00
.word 0x0500, 0x0D00
.word 0x0600, 0x0E00
.word 0x0700, 0x0F00
