
int_en_timer0:

  # 8254 Timer
  # 0x2E9C(11932) = 10[ms] @ CLK = 1,193,182[Hz]
  # set Timer interrupt every 10[ms](0x2E9C count)
  push %eax
  outp $0x43, $0b00110100 # take turns low byte / high byte, mode 2, binary
  outp $0x40, $0x9C # low byte
  outp $0x40, $0x2E # high byte

  pop %eax
  ret
