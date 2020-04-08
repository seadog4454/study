int_default:
  pushf
  push %cs
  push $int_stop
  mov $.s0, %eax
  iret

.s0: .string "<     STOP    >"

int_stop:
  push %eax
  push $0x060F
  push $0xF
  push $0x19
  call draw_str
  add $0x10, %sp

  mov (%esp), %eax
  push $0b0100
  push $0x10
  push $0x8
  push $.p1
  push %eax
  call itoa
  add $0x14, %sp


  mov 0x4(%esp), %eax
  push $0b0100
  push $0x10
  push $0x8
  push $.p2
  push %eax
  call itoa
  add $0x14, %sp


  mov 0x8(%esp), %eax
  push $0b0100
  push $0x10
  push $0x8
  push $.p3
  push %eax
  call itoa
  add $0x14, %sp


  mov 0xc(%esp), %eax
  push $0b0100
  push $0x10
  push $0x8
  push $.p4
  push %eax
  call itoa
  add $0x14, %sp

  push $.s1
  push $0x0F04
  push $0x10
  push $0x19
  call draw_str
  add $0x10, %sp


  push $.s2
  push $0x0F04
  push $0x11
  push $0x19
  call draw_str
  add $0x10, %sp


  push $.s3
  push $0x0F04
  push $0x12
  push $0x19
  call draw_str
  add $0x10, %sp


  push $.s4
  push $0x0F04
  push $0x13
  push $0x19
  call draw_str
  add $0x10, %sp

  jmp .

.s1: .ascii "ESP+ 0:"
.p1: .string "________ "
.s2: .ascii "   + 4:"
.p2: .string "________ "
.s3: .ascii "   + 8:"
.p3: .string "________ "
.s4: .ascii "   +0C:"
.p4: .string "________ "
