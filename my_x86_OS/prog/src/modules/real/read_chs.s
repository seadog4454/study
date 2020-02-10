/*
 * read_chs(drive, sect, dst)
 * return: number of read sectors: ax register
 * args:
 *		drive: addr of struct drive
 *		sect: number of sectors you want to read
 *		dst: 
 */


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

	mov 0x4(%bp), %si
	mov ()
