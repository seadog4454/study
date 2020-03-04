/*
 * get_font_adr(adr)
 * return: void
 * arguments:
 *  adr: Store position of the font address
 */

.code16

get_font_adr:
  push %bp
  mov %sp, %bp

  push %ax
  push %bx
  push %si
  push %es
  push %bp

  mov 0x4(%bp), %si
  
  /*
   * font type(%bh):
   *  0x00: 8*8
   *  0x02: 8*14
   *  0x03: 8*8
   *  0x05: 9*14
   *  0x06: 8*16
   *  0x07: 9*16
   */

  mov $0x1130, %ax # ax == 0x1130: get font address with "int 0x10"
  mov $0x6, %bh # font type
  int $0x10 # bios call: video service

  mov %es, (%si)
  mov %bp, 0x2(%si)

  pop %bp
  pop %es
  pop %si
  pop %bx
  pop %ax

  mov %bp, %sp
  pop %bp

  ret

