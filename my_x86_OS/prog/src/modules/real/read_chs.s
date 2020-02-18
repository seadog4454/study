/*
 * read_chs(drive, sect, dst)
 * return: number of read sectors: ax register
 * args:
 *		drive: addr of struct drive
 *      no: drive number
 *      cyln: cylinder
 *      head: head
 *      sect: sector
 *		sect: number of sectors you want to read
 *		dst: 
 */

.code16
.section .text

read_chs:
	push %bp
	mov %sp, %bp

	push $3  # number of retries
	push 0 # number of read sector

	push %bp
	push %cx
	push %dx
	push %es
	push %si

	mov 0x4(%bp), %si # src buff
	
  mov drive.cyln(%si), %ch
  mov drive.cyln(%si, 0x1), %cl
  shl $6, %cl
  or drive.sect(%si), %cl
  
  mov drive.head(%si), %dh
  mov drive.no(%si), %dl
  mov %ax, %es
  mov 0x8(%bp), %bx # dist copy

.read_chs1L:
  mov $0x2, %ah
  mov 0x6(%bp), %al

  int $0x13
  jnc .read_chs1E

  mov $0, %al
  jmp .read_chs2E
.read_chs1E:
  
  cmp $0, %al
  jne .read_chs2E

  mov $0, %ax
  decw -0x2(%bp)
  jnz .read_chs1L
.read_chs2E:
  mov $0, %ah

  pop %si
  pop %es
  pop %dx
  pop %cx
  pop %bx

  mov %bp, %sp
  pop %bp

  ret



.section .data

.set drive.size, 6
drive:
	.struct 0
drive.no: 
	.struct drive.no + 2
drive.cyln: 
	.struct drive.cyln + 2
drive.head: 
	.struct drive.head + 2
drive.sect: 
drive.end:
