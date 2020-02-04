.code16

# void itoa(num, buff, size, radix, flag)
# num:source addr
# buff:dist addr
# radix:set 2, 8, 10, or 16 
# flag:When set 
#                 1st bit: 0 padding on space
#                 2nd bit: add +/- sign
#                 3rd bit: treat as signed variable 


itoa:
  push %bp
  mov %sp, %bp

# store register
  push %ax
  push %bx
  push %cx
  push %dx
  push %si
  push %di

# get arguments
  mov 0x4(%bp), %ax # num
  mov 0x6(%bp), %si # buff
  mov 0x8(%bp), %cx # size
  mov 0xc(%bp), %bx # flag
# The remaining arguments(radix: 0xa(%bp) ) will be assigend later.
  mov %si, %di
  add %cx, %di
  dec %di



# detect signed variable
  test $0b0001, %bx
  jz .Litoa1
  cmp $0, %ax
  jge .Litoa2
  or $0b0010, %bx
.Litoa1: 
.Litoa2:

# detect add +/- sign
  test $0b0010, %bx
  jz .Litoa3
  cmp $0, %ax
  jge .Litoa4
  neg %ax
  movb $0x2d, (%si) # 0x2d == '-'
  jmp .Litoa5
.Litoa4:
  movb $0x2b, (%si) # 0x2b == '+'
.Litoa5:
  dec %cx
.Litoa3:

# convert to ascii
  mov 0xa(%bp), %bx
.LitoaLOOP1:
  mov $0, %dx
  div %bx
  mov %dx, %si
  movb ascii_table(%si), %dl
  mov %dl, (%di)
  dec %di
  cmp $0, %ax
  loopnz .LitoaLOOP1
.LotpaLOOPEND1:


# 0 padding in the space
  cmp $0, %cx
  je .Litoa6
  mov $0x20, %al
  cmp $0b0100, 0xc(%bp)
  jne .Litoa7
  mov $0x30, %al
.Litoa7:
  std
  rep stosb
.Litoa6:

# return register
  pop %di
  pop %si
  pop %dx
  pop %cx
  pop %bx
  pop %ax

# destroy stack frame
  mov %bp, %sp
  pop %bp
  ret



ascii_table: .string "0123456789ABCDEF"
