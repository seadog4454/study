.equ PINC, 0x6
.equ DDRC, 0x7
.equ PORTC, 0x8
.equ TRUE, 0x1

.section .text
.org 0x0000
  rjmp reset
  
reset:
  eor r16, r16
  out DDRC, r16
  ldi r16, 0x4
  out DDRC, r16
  
.loop:
  in r16, PINC
  andi r16, 0x10
  breq .blight
  brne .unblight

.blight:
  out PORTC, 0x4
  rjmp .L1

.unblight:
  out PORTC, 0x0
  rjmp .L1

.L1:
  ldi r17, TRUE
  mov r18, r17
  sub r17, r18
  breq .loop

  rjmp reset
