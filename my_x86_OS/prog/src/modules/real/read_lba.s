/*
 * read_lba(drive, lba, sect , dst)
 * arguments:
 *	drive: struct drive
 *	lba: LBA
 *	sect: read sector
 *	dst:	store address
 */

read_lba:
 	push %bp
	mov %sp, %bp

	push %si

	mov 0x4(%bp), %si
	
	mov 0x6(%bp), %ax
	
	push %ax
	push $.Lread_lba_chs
	push %si
	call lba_chs
	add $0x6, %sp

	mov drive.no(%si), %al
	mov %al, (.Lread_lba_chs + drive.no)

	pushw 0xa(%bp)
	pushw 0x8(%bp)
	push $.Lread_lba_chs
	call read_chs
	add $0x6, %sp

	pop %si
	mov %bp, %sp
	pop %bp

	ret

.align 2
.Lread_lba_chs: .space drive.size
