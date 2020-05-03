/*
 * get_drive_param(drive);
 * return:
 *  sucsess: other than 0
 *  false: 0
 * arguments:
 *  arg1: drive struct(ref. read_chs.s)
 */

.code16

get_drive_param:
  push %bp
  mov %sp, %bp

  push %bx
  push %cx
  push %es
  push %si
  push %di

  mov 0x4(%bp), %si

  xor %ax, %ax
  mov %ax, %es
  mov %ax, %di

  mov $8, %ah
  mov drive.no(%si), %dl
  int $0x13
  jc .Lget_drive_param1

  mov %cl, %al
  and $0x3F, %ax

  shr $6, %cl
  ror $8, %cx
  inc %cx

  movzx %dh, %bx
  inc %bx

  mov %cx, drive.cyln.low(%si)
  mov %bx, drive.head(%si)
  mov %ax, drive.sect(%si)

  jmp .Lget_drive_param2


.Lget_drive_param1:
  mov $0, %ax

.Lget_drive_param2:
  pop %di
  pop %si
  pop %es
  pop %cx
  pop %bx

  mov %bp, %sp
  pop %bp

  ret
