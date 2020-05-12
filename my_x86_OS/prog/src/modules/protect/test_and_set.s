test_and_set:
  push %ebp
  mov %esp, %ebp

  push %eax
  push %ebx

  mov $0x0, %eax
  mov 0x8(%ebp), %ebx

10:

  lock bts %eax, (%ebx)
  jnc 10f
  
12:

  bt %eax, (%ebx)
  jc 12b
  jmp 10b

10:
  
  pop %ebx
  pop %eax
  
  mov %ebp, %esp
  pop %ebp

  reg
