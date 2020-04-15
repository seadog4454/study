.macro set_vect interruptNum, funcAddr
  push %eax
  push %edi
  mov $VECT_BASE + (\interruptNum * 8), %edi
  mov \funcAddr, %eax

  mov %ax, (%edi)
  shr $0x10, %eax
  mov %ax, 0x6(%edi)

  pop %edi
  pop %eax
.endm

.macro outp port, val
  mov \val, %al
  out %al, \port
.endm
