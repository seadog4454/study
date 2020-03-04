/*
 * get_mem_info(void)
 */

 .code16

 get_mem_info:
  push %eax
  push %ebx
  push %ecx
  push %edx
  push %si
  push %di
  push %bp

  push $.Lget_mem_info_s3
  call puts
  add $2, %sp

  mov $0x0, %bp # lines = 0
  mov $0x0, %ebx # initialize index

.Lget_mem_info_1L:
  /* bios call, get memory info  int 0x15(eax=0xE820)*/
  mov $0x0000E820, %eax 
  mov E820_RECORD_SIZE, %ecx # byte size
  mov $0x50414D53, %edx # edx = "SMAP" = signature
  mov $.Lget_mem_info_b0, %di # distination: buffer
  int $0x15

  cmp $0x50414D53, %eax
  je .Lget_mem_info_1E
  jmp .Lget_mem_info_2E

.Lget_mem_info_1E:
  jnc .Lget_mem_info_3E
  jmp .Lget_mem_info_2E

.Lget_mem_info_3E:
  push %di
  call put_mem_info

  mov 0xf(%di), %eax
  cmp $3, %eax
  jne .Lget_mem_info_5E

  mov (%di), %eax
  mov %eax, (ACPI_DATA.adr)
  
  mov 0x8(%di), %eax
  mov %eax, (ACPI_DATA.len)

.Lget_mem_info_5E:
  cmp $0, %ebx
  jz .Lget_mem_info_6E
  
  inc %bp
  and $0x7, %bp
  jnz .Lget_mem_info_6E
  
  push $.Lget_mem_info_s0
  call puts
  add $2, %sp
  mov 0x10, %ah
  int $0x16
  push $.Lget_mem_info_s1
  call puts
  add $2, %sp

.Lget_mem_info_6E:

  cmp $0, %ebx
  jne .Lget_mem_info_1L
.Lget_mem_info_2E:
  
  push $.Lget_mem_info_s5
  call puts
  add $2, %sp



.equ E820_RECORD_SIZE, 0x20

.Lget_mem_info_s0: .string "<more...>"
.Lget_mem_info_s1: .string "\r        \r"
.Lget_mem_info_s2: .string "\r        \r"

.Lget_mem_info_s3: .ascii "E820 Memory Map\r\n"
.Lget_mem_info_s4: .string " Base_____________ Length___________ Type____\r\n"
.Lget_mem_info_s5: .string " ----------------- ----------------- --------\r\n"

.align 4
.Lget_mem_info_b0: .space E820_RECORD_SIZE

/*
 * put_mem_info(adr)
 * return void
 * arguments:
 *  adr: address to refer to the memory infomation
 */

.code16
put_mem_info:
  push %bp
  mov %sp, %bp

  push %bx
  push %si

  mov 0x4(%bp), %si
  mov $.Lput_mem_info_p2, %bp
  push $0b0100
  push $16
  push $4
  push %bp
  pushw 0x6(%si)
  call itoa
  add $0xa, %sp

  push $.Lput_mem_info_s1
  call puts
  add $2, %sp

  mov 0xf(%si), %bx
  and $0x7, %bx
  shl $1, %bx
  add $.Lput_mem_info_t0, %bx
  pushw %bx
  call puts
  add $2, %sp

  pop %si
  pop %bx

  mov %bp, %sp
  pop %bp

  ret

.Lput_mem_info_s1: .ascii " "

.Lput_mem_info_p1: .ascii "ZZZZZZZZ_"
.Lput_mem_info_p2: .ascii "ZZZZZZZZ "
.Lput_mem_info_p3: .ascii "ZZZZZZZZ_"
.Lput_mem_info_p4: .ascii "ZZZZZZZZ "
.Lput_mem_info_p5: .string "ZZZZZZZZ"

.Lput_mem_info_s2: .string "(Unknown)\r\n"
.Lput_mem_info_s3: .string "(usable)\r\n"
.Lput_mem_info_s4: .string "(reserved)\r\n"
.Lput_mem_info_s5: .string "(ACPI data)\r\n"
.Lput_mem_info_s6: .string "(ACPI NVS)\r\n"
.Lput_mem_info_s7: .string "(bad memory)\r\n"

.Lput_mem_info_t0: .word .Lput_mem_info_s2, .Lput_mem_info_s3, .Lput_mem_info_s4, .Lput_mem_info_s5, .Lput_mem_info_s6, .Lput_mem_info_s7, .Lput_mem_info_s2, .Lput_mem_info_s2