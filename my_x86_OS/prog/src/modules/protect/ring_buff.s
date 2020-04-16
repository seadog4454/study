ring_rd:
  push %ebp
  mov %esp, %ebp

  push %ebx
  push %esi
  push %edi

  mov 0x8(%ebp), %esi
  mov 0xc(%ebp), %edi

  mov $0x0, %eax
  mov ring_buff.rp(%esi), %ebx
  cmp ring_buff.wp(%esi), %ebx
  je .10E

  mov ring_buff.item(%ebx, %esi), %al
  mov %al, (%edi)

  inc %ebx
  and $RING_INDEX_MASK, %ebx
  mov %ebx, ring_buff.rp(%esi)
  mov $0x1, %eax
.10E:

  pop %edi
  pop %esi
  pop %ebx

  mov %ebp, %esp
  pop %ebp

  ret

ring_wr:
  push %ebp
  mov %esp, %ebp

  push %ebx
  push %ecx
  push %esi

  mov 0x8(%ebp), %esi
  mov $0x0, %eax
  mov ring_buff.wp(%esi), %ebx
  mov %ebx, %ecx
  inc %ecx
  and $RING_INDEX_MASK, %ecx

  cmp ring_buff.rp(%esi), %ecx
  je .ringwr_10E
  mov 0xc(%ebp), %al

  mov %al, ring_buff.item(%esi, %ebx)
  mov %ecx, ring_buff.wp(%esi)
  mov $0x1, %eax
.ringwr_10E:

  pop %esi
  pop %ecx
  pop %ebx

  mov %ebp, %esp
  pop %ebp

  ret

draw_key:
  push %ebp
  mov %esp, %ebp

  pusha

  mov 0x8(%ebp), %edx
  mov 0xc(%ebp), %edi
  mov 0x10(%ebp), %esi

  mov ring_buff.rp(%esi), %ebx
  lea ring_buff.item(%esi), %esi
  mov $RING_ITEM_SIZE, %ecx

.draw_key10L:
  
  dec %ebx
  and $RING_INDEX_MASK, %ebx
  mov (%esi, %ebx), %al



  push $0b0100
  push $0x10
  push $0x2
  push $.tmp
  push %eax
  call itoa
  add $0x14, %sp

  push $.tmp
  push $0x02
  push %edi
  push %edx
  call draw_str
  add $0x10, %sp

  add $0x3, %edx
  loop .draw_key10L

.draw_key_10E:

  popa

  mov %ebp, %esp
  pop %ebp

  ret

.tmp: .string "__ "

.section .data

ring_buff: .struct 0
ring_buff.rp: .struct ring_buff.rp + 4
ring_buff.wp: .struct ring_buff.wp + 4
ring_buff.item: .struct ring_buff.item + RING_ITEM_SIZE
ring_buff.end:

#.set ring_buff.size, 0x4
.set ring_buff.size, ring_buff.end - ring_buff.rp

.section .text
