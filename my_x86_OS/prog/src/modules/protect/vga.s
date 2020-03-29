/*
 *  vga_set_read_plane(plane)
 *  arguments:
 *    plane:  reading plane
 *  return: void
 */
vga_set_read_plane:
  push %ebp
  mov %esp, %ebp

  push %eax
  push %edx

  mov 0x8(%ebp), %ah
  and $0x03, %ah
  mov $0x04, %al
  mov $0x03CE, %dx
  out %ax, %dx

  pop %edx
  pop %eax

  mov %ebp, %esp
  pop %ebp

  ret


/*
 * vga_set_write_plane(plane)
 * arguments:
 *  plane:  writing plane
 * return: void
 */

vga_set_write_plane:
  push %ebp
  mov %esp, %ebp

  push %eax
  push %edx

  mov 0x8(%ebp), %ah
  and $0xF, %ah
  mov $0x2, %al
  mov $0x03C4, %dx
  out %ax, %dx
  
  pop %edx
  pop %eax

  mov %ebp, %esp
  pop %ebp
  ret

/*
 * vram_font_copy(font, vram, plane, color)
 * arguments:
 *  font: font addr
 *  vram: vram addr
 *  plane:  output plane
 *  color:  drawing color
 * reutnr: void
 */

vram_font_copy:
  push %ebp
  mov %esp, %ebp

  push %eax
  push %ebx
  push %ecx
  push %edx
  push %esi
  push %edi

  mov 0x8(%ebp), %esi # font
  mov 0xc(%ebp), %edi # vram
  movzxb 0x10(%ebp), %eax # plane
  movzxw 0x14(%ebp), %ebx # color

  test %al, %bh
  setz %dh
  dec %dh

  test %al, %bl
  setz %dl
  dec %dl

  # copy 16 dot's font
  cld

  mov $0x10, %ecx
.Lvram_font_copy_10L:
  
  # create font mask
  lodsb
  mov %al, %ah
  not %ah
  
  # front color(font color)
  and %dl, %al

  # background color
  test $0x0010, %ebx
  jz .Lvram_font_copy_11F
  and (%edi), %ah
  jmp .Lvram_font_copy_11E

.Lvram_font_copy_11F:
  and %dh, %ah

.Lvram_font_copy_11E:

  # merge front and background color
  or %ah, %al

  mov %al, (%edi)
  
  add $80, %edi
  loop .Lvram_font_copy_10L

.Lvram_font_copy_10E:

  pop %edi
  pop %esi
  pop %edx
  pop %ecx
  pop %ebx
  pop %eax

  mov %ebp, %esp
  pop %ebp

  ret





/*
 *  vram_bit_copy(bit, vram, plane, color)
 *  arguments:
 *    bit:  bit pattern
 *    vram: vram addr
 *    plane:
 *    color:
 *
 */

vram_bit_copy:
  push %ebp
  mov %esp, %ebp

  push %eax
  push %ebx
  push %edi

  mov 0xc(%ebp), %edi # vram addr
  movzxb 0x10(%ebp), %eax # plane
  movzxw 0x14(%ebp), %ebx # color

  test %al, %bl
  setz %bl
  dec %bl

  mov 0x8(%ebp), %al
  mov %al, %ah
  not %ah

  and (%edi), %ah
  and %bl, %al
  or %ah, %al
  
  mov %al, (%edi)

  pop %edi
  pop %ebx
  pop %eax

  mov %ebp, %esp
  pop %ebp
  
  ret
