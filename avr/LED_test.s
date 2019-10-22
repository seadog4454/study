	.file	"LED_test.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	wait
	.type	wait, @function
wait:
	push r28
	push r29
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
/* stack size = 4 */
.L__stack_usage = 4
	std Y+2,__zero_reg__
	std Y+1,__zero_reg__
	std Y+2,__zero_reg__
	std Y+1,__zero_reg__
	rjmp .L2
.L3:
	ldd r24,Y+1
	ldd r25,Y+2
	adiw r24,1
	std Y+2,r25
	std Y+1,r24
.L2:
	ldd r24,Y+1
	ldd r25,Y+2
	cpi r24,-72
	sbci r25,11
	brlt .L3
	nop
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	wait, .-wait
.global	main
	.type	main, @function
main:
	push r28
	push r29
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
/* stack size = 4 */
.L__stack_usage = 4
	std Y+2,__zero_reg__
	std Y+1,__zero_reg__
	ldi r24,lo8(39)
	ldi r25,0
	movw r30,r24
	st Z,__zero_reg__
	ldi r24,lo8(39)
	ldi r25,0
	ldi r18,lo8(39)
	ldi r19,0
	movw r30,r18
	ld r18,Z
	ori r18,lo8(4)
	movw r30,r24
	st Z,r18
.L7:
	ldi r24,lo8(38)
	ldi r25,0
	movw r30,r24
	ld r24,Z
	mov r24,r24
	ldi r25,0
	andi r24,16
	clr r25
	or r24,r25
	breq .L5
	ldi r24,lo8(40)
	ldi r25,0
	ldi r18,lo8(4)
	movw r30,r24
	st Z,r18
	rjmp .L7
.L5:
	ldi r24,lo8(40)
	ldi r25,0
	movw r30,r24
	st Z,__zero_reg__
	rjmp .L7
	.size	main, .-main
	.ident	"GCC: (GNU) 5.4.0"
