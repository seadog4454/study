	.file	"test_serial.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.section	.rodata
.LC0:
	.string	"Hello world"
	.text
.global	main
	.type	main, @function
main:
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,14
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 14 */
/* stack size = 16 */
.L__stack_usage = 16
	ldi r24,lo8(12)
	ldi r30,lo8(.LC0)
	ldi r31,hi8(.LC0)
	movw r26,r28
	adiw r26,3
	0:
	ld r0,Z+
	st X+,r0
	dec r24
	brne 0b
	std Y+2,__zero_reg__
	std Y+1,__zero_reg__
	ldi r24,lo8(42)
	ldi r25,0
	ldi r18,lo8(-4)
	movw r30,r24
	st Z,r18
	ldi r24,lo8(43)
	ldi r25,0
	movw r30,r24
	st Z,__zero_reg__
	ldi r24,lo8(-59)
	ldi r25,0
	movw r30,r24
	st Z,__zero_reg__
	ldi r24,lo8(-60)
	ldi r25,0
	ldi r18,lo8(12)
	movw r30,r24
	st Z,r18
	ldi r24,lo8(-64)
	ldi r25,0
	movw r30,r24
	st Z,__zero_reg__
	ldi r24,lo8(-63)
	ldi r25,0
	ldi r18,lo8(24)
	movw r30,r24
	st Z,r18
	ldi r24,lo8(-62)
	ldi r25,0
	ldi r18,lo8(6)
	movw r30,r24
	st Z,r18
.L5:
	std Y+2,__zero_reg__
	std Y+1,__zero_reg__
	rjmp .L2
.L4:
	nop
.L3:
	ldi r24,lo8(-64)
	ldi r25,0
	movw r30,r24
	ld r24,Z
	mov r24,r24
	ldi r25,0
	andi r24,32
	clr r25
	or r24,r25
	breq .L3
	ldi r24,lo8(-58)
	ldi r25,0
	movw r20,r28
	subi r20,-3
	sbci r21,-1
	ldd r18,Y+1
	ldd r19,Y+2
	add r18,r20
	adc r19,r21
	movw r30,r18
	ld r18,Z
	movw r30,r24
	st Z,r18
	ldd r24,Y+1
	ldd r25,Y+2
	adiw r24,1
	std Y+2,r25
	std Y+1,r24
.L2:
	movw r18,r28
	subi r18,-3
	sbci r19,-1
	ldd r24,Y+1
	ldd r25,Y+2
	add r24,r18
	adc r25,r19
	movw r30,r24
	ld r24,Z
	tst r24
	brne .L4
	rjmp .L5
	.size	main, .-main
	.ident	"GCC: (GNU) 5.4.0"
.global __do_copy_data
