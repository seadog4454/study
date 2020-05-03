/*
 * lba_chs(drive, drv_chs, lba)
 * arguments:
 *  drive: struct drive
 *  drb_chs: struct drive to chs
 *  lba : sector number
 */

 lba_chs:
  push %bp
  mov %sp, %bp

  push %ax
  push %bx
  push %dx
  push %si
  push %di

  mov 0x4(%bp), %si
  mov 0x6(%bp), %di

  # get sectors per cylinder
  mov drive.head(%si), %al # AL = max heads
  mulb drive.sect(%si)
  mov %ax, %bx
  
  mov $0, %dx
  mov 0x8(%bp), %ax
  div %bx

  mov %ax, drive.cyln.low(%di)

  mov %dx, %ax
  divb  drive.sect(%si)

  movzx %ah, %dx
  inc %dx

  mov $0x00 , %ah

  mov %ax, drive.head(%di)
  mov %dx, drive.sect(%di)

  pop %di
  pop %si
  pop %dx
  pop %bx
  pop %ax

  mov %bp, %sp
  pop %bp

  ret

