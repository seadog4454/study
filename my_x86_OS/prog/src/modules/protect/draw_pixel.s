/*
 *  draw_pixel(X, Y, color)
 *  X:
 *  Y:
 *  color:
 *  return: void
 */


draw_pixel:

  push %ebp
  mov %esp, %ebp

  push %eax
  push %ebx
  push %Ecx
  push %edi

  mov 0xc(%ebp), %edi # Y
  shl $0x4, %edi
  lea VRAM(%edi, %edi, 0x4), %edi
  
  mov 0x8(%ebp), %ebx
  mov %ebx, %ecx
  shr $0x3, %ebx
  add %ebx, %edi

  and $0x7, %ecx
  mov $0x80, %ebx
  shr %cl, %ebx

  mov 0x10(%ebp), %ecx

  push $0x03
  call vga_set_read_plane
  add $0x04, %sp

  push $0x08
  call vga_set_write_plane
  add $0x04, %sp

  push %ecx
  push $0x08
  push %edi
  push %ebx
  call vram_bit_copy
  add $0x10, %sp


  push $0x02
  call vga_set_read_plane
  add $0x04, %sp

  push $0x04
  call vga_set_write_plane
  add $0x04, %sp

  push %ecx
  push $0x04
  push %edi
  push %ebx
  call vram_bit_copy
  add $0x10, %sp


  push $0x01
  call vga_set_read_plane
  add $0x04, %sp

  push $0x02
  call vga_set_write_plane
  add $0x04, %sp

  push %ecx
  push $0x02
  push %edi
  push %ebx
  call vram_bit_copy
  add $0x10, %sp



  push $0x00
  call vga_set_read_plane
  add $0x04, %sp

  push $0x01
  call vga_set_write_plane
  add $0x04, %sp

  push %ecx
  push $0x01
  push %edi
  push %ebx
  call vram_bit_copy
  add $0x10, %sp


  pop %edi
  pop %ecx
  pop %ebx
  pop %eax

  mov %ebp, %esp
  pop %ebp

  ret
