/*
 *  draw_char(col, row, color, ch)
 *  arguments:
 *    col: 0 ~ 79
 *    row: 0 ~ 29
 *    color: drawing color
 *    ch : char
 *  return : null
 */

.include "./define.s"

draw_char:
  push %ebp
  mov %esp, %ebp

  push %eax
  push %ebx
  push %ecx
  push %edx
  push %esi
  push %edi

.ifdef USE_TEST_AND_SET
  push $IN_USE
  call test_and_set
  add $0x4, %sp
.endif

  # get font addr
  movzxb 0x14(%ebp), %esi # font addr
  shl $0x4, %esi
  add (FONT_ADR), %esi

  mov 0xc(%ebp), %edi # row
  shl $0x8, %edi
  lea VRAM(%edi, %edi, 0x4), %edi
  add 0x8(%ebp), %edi # col
  
  # put char
  movzxw 0x10(%ebp), %ebx # color
 
  push $0x03
  call vga_set_read_plane
  add $0x4, %sp
  
  push $0x08
  call vga_set_write_plane
  add $0x4, %sp

  push %ebx
  push $0x08
  push %edi
  push %esi
  call vram_font_copy
  add $0x10, %sp

  
  push $0x02
  call vga_set_read_plane
  add $0x4, %sp
  
  push $0x04
  call vga_set_write_plane
  add $0x4, %sp

  push %ebx
  push $0x04
  push %edi
  push %esi
  call vram_font_copy
  add $0x10, %sp


  push $0x01
  call vga_set_read_plane
  add $0x4, %sp
  
  push $0x02
  call vga_set_write_plane
  add $0x4, %sp

  push %ebx
  push $0x02
  push %edi
  push %esi
  call vram_font_copy
  add $0x10, %sp

  push $0x00
  call vga_set_read_plane
  add $0x4, %sp
  
  push $0x01
  call vga_set_write_plane
  add $0x4, %sp

  push %ebx
  push $0x01
  push %edi
  push %esi
  call vram_font_copy
  add $0x10, %sp

.ifdef USE_TEST_AND_SET
  movl $0x0, (IN_USE)
.endif

  pop %edi
  pop %esi
  pop %edx
  pop %ecx
  pop %ebx
  pop %eax

  mov %ebp, %esp
  pop %ebp

  ret

.ifdef USE_TEST_AND_SET
  .align 0x4
  IN_USE: .long 0x0
.endif
