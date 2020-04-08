/*
 *  draw_time(col, row, color, time)
 *  arguments:
 *    col:
 *    row:
 *    color:
 *    time:
 *  return: void
 */


 draw_time:

  push %ebp
  mov %esp, %ebp

  push %eax
  push %ebx

  mov 0x14(%ebp), %eax
  cmp (.last), %eax
  je .Ldraw_time_10E

  mov %eax, (.last)
  

  mov $0x0, %ebx
  mov %al, %bl
  push $0b100
  push $0x10
  push $0x2
  push $.sec
  push %ebx
  call itoa
  add $0x14, %sp
  
  mov %ah, %bl
  push $0b100
  push $0x10
  push $0x2
  push $.min
  push %ebx
  call itoa
  add $0x14, %sp

  shr $0x10, %eax
  push $0b100
  push $0x10
  push $0x2
  push $.hour
  push %eax
  call itoa
  add $0x14, %sp

  push $.hour
  pushl 0x10(%ebp)
  pushl 0xc(%ebp)
  pushl 0x8(%ebp)
  call draw_str
  add $0x10, %esp

.Ldraw_time_10E:

  pop %ebx
  pop %eax

  mov %ebp, %esp
  pop %ebp

  ret

.align 2
.temp:  .quad 0x0
.last:  .quad 0x0
.hour:  .ascii "ZZ:"
.min:   .ascii "ZZ:"
.sec:   .string "ZZ"
