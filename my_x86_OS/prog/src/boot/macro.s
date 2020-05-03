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

.macro set_desc1 descriptoraddr, baseaddr
  push %eax
  push %edi

  mov \descriptoraddr, %edi
  mov \baseaddr, %eax

  mov %ax, 0x2(%edi)
  shr $0x10, %eax
  mov %al, 0x4(%edi)
  mov %ah, 0x7(%edi)

  pop %edi
  pop %eax
.endm


.macro set_desc2 descriptoraddr, baseaddr, limit
  push %eax
  push %edi

  mov \descriptoraddr, %edi
  mov \baseaddr, %eax
  movw \limit, (%edi)

  mov %ax, 0x2(%edi)
  shr $0x10, %eax
  mov %al, 0x4(%edi)
  mov %ah, 0x7(%edi)

  pop %edi
  pop %eax
.endm
