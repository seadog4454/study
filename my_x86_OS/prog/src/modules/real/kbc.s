/*
 * KBC_Data_Write(data)
 * return:
 *  sucsess: other than o
 *  false: 0
 * argumetns:
 *  data: the value to write buffer in KBC
 */

.code16

KBC_Data_Write:
  push %bp
  mov %sp, %bp

  push %cx

  mov $0, %cx

# read KBC status
.LKBC_Data_Write_10L:
  in $0x64, %al # port KBC status
  test $0x02, %al # Is writeable
  loopnz .LKBC_Data_Write_10L
  
  cmp $0, %cx
  jz .LKBC_Data_Write_20E

  mov 0x4(%bp), %al
  out %al, $0x60

.LKBC_Data_Write_20E:
  
  mov %cx, %ax

  pop %cx

  mov %bp, %sp
  pop %bp

  ret



/*
 * KBC_Data_Read(data)
 * return:
 *  sucsess: Other than 0
 *  false: 0
 * arguments:
 *  data: Address to store read value from KBC
 */

KBC_Data_Read:
  push %bp
  mov %sp, %bp

  push %cx
  push %di

  mov $0, %cx

.LKBC_Data_Read_10L:
  in $0x64, %al # KBC status
  test $0x01, %al # Is readable
  loopz .LKBC_Data_Read_10L

  cmp $0, %cx
  jz .LKBC_Data_Read_20E

  mov $0x0, %ah
  in $0x60, %al # read data

  mov 0x4(%bp), %di
  mov %ax, (%di)
.LKBC_Data_Read_20E:

  mov %cx, %ax

  pop %di
  pop %cx

  mov %bp, %sp
  pop %bp

  ret


/*
 * KBC_Cmd_Write(Cmd)
 * return:
 *  sucsess: Other than 0
 *  false: 0
 * arguemnts:
 *  Cmd: command to send to KBC
 */

KBC_Cmd_Write:
  push %bp
  mov %sp, %bp

  push %cx

  mov $0, %cx
.LKBC_Cmd_Write_10L:

  in $0x64, %al # KBC status
  test $0x02, %al
  loopnz .LKBC_Cmd_Write_10L

  cmp $0, %cx
  jz .LKBC_Cmd_Write_20E

  mov 0x04(%bp), %al
  out %al, $0x64 # KCB cmd write
.LKBC_Cmd_Write_20E:


  mov %cx, %ax

  pop %cx

  mov %bp, %sp
  pop %bp

  ret
