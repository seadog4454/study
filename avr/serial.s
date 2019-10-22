.equ UBRR0L, 0xc4
.equ UBRR0H, 0xc5
.equ UDR0, 0xc6
.equ UCSR0B, 0xc1
.equ UCSR0C, 0xc2
.equ UCSR0A, 0xc0
.equ DDRD, 0xA
.equ PORTD, 0xB

.section .text
  .org 0x0000
  rjmp reset


reset:
  rcall initSerial
  rcall loop

loop:
  rcall puttx
  rjmp loop
  ret
 

initSerial:
  ldi r16, 0b11111100
  OUT DDRD, r16
  ldi r16, 0b00000000
  OUT PORTD, r16

  /* set boud rate 
    UBRRn = (f_osc / (16 * BAUD)) - 1
    f_osc = 1MHz
    BAND = 9600
    UBRR = 12
  */

  clr r16
  sts  UBRR0H, r16
  ldi r16, 0xc
  sts UBRR0L, r16
  
  /* enable rx tx */
  ldi r16, 0b00011000
  sts UCSR0B, r16

  /* no parity, asynchronous, stop 1bit */
  ldi r16, 0b00000110
  sts UCSR0C, r16
  ret


puttx:
  ldi r17, .teststr
.Lp3:
  lds r18, r17
  ori r18, 0x0
  breq .Lp2
  lds r16, UCSR0A
  sbrs r16, 5
  rjmp .Lp3
  sts UDR0, r18
  inc r17
  rjmp .Lp3
.Lp2:
  ret


.section .rodate

.teststr:
  .string, "Ok"
