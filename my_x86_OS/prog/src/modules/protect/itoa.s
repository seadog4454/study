# void itoa(num, buff, size, radix, flag)
# num:source addr
# buff:dist addr
# radix:set 2, 8, 10, or 16 
# flag:When set 
#                 1st bit: 0 padding on space
#                 2nd bit: add +/- sign
#                 3rd bit: treat as signed variable 


itoa:
  push %ebp
  mov %esp, %ebp

# store register
  push %eax
  push %ebx
  push %ecx
  push %edx
  push %esi
  push %edi

# get arguments
  mov 0x8(%ebp), %eax # num
  mov 0xc(%ebp), %esi # buff
  mov 0x10(%ebp), %ecx # size
  mov 0x18(%ebp), %ebx # flag
# The remaining arguments(radix: 0xa(%bp) ) will be assigend later.
  mov %esi, %edi
  add %ecx, %edi
  dec %edi



# detect signed variable
  test $0b0001, %ebx
  jz .Litoa1
  cmp $0, %eax
  jge .Litoa2
  or $0b0010, %ebx
.Litoa1: 
.Litoa2:

# detect add +/- sign
  test $0b0010, %ebx
  jz .Litoa3
  cmp $0, %eax
  jge .Litoa4
  neg %eax
  movb $0x2d, (%esi) # 0x2d == '-'
  jmp .Litoa5
.Litoa4:
  movb $0x2b, (%esi) # 0x2b == '+'
.Litoa5:
  dec %ecx
.Litoa3:

# convert to ascii
  mov 0x14(%ebp), %ebx
.LitoaLOOP1:
  mov $0, %edx
  div %ebx
  mov %edx, %esi
  movb ascii_table(%esi), %dl
  mov %dl, (%edi)
  dec %edi
  cmp $0, %eax
  loopnz .LitoaLOOP1
.LotpaLOOPEND1:


# 0 padding in the space
  cmp $0, %ecx
  je .Litoa6
  mov $0x20, %al
  cmpw $0b0100, 0x18(%ebp)
  jne .Litoa7
  mov $0x30, %al
.Litoa7:
  std
  rep stosb
.Litoa6:

# return register
  pop %edi
  pop %esi
  pop %edx
  pop %ecx
  pop %ebx
  pop %eax

# destroy stack frame
  mov %ebp, %esp
  pop %ebp
  ret



ascii_table: .string "0123456789ABCDEF"
