/*
 *  rtc_get_time(dst)
 *  arguments:
 *    dst:  stored address
 *  return:
 *    0:  sucsess
 *    other:  false
 */
rtc_get_time:
  push %ebp
  mov %esp, %ebp

  push %ebx

  mov $0x4, %al # hour data
  out %al, $0x70
  in $0x71, %al
  
  shl $0x8, %eax # hour 00

  mov $0x2, %al # minute
  out %al, $0x70
  in $0x71, %al 
  
  shl $0x8, %eax # hour minute 00

  mov $0x0, %al # second
  out %al, $0x70
  in $0x71, %al # hour minute second 00

  and $0x00FFFFFF, %eax # FF(hour) FF(minute) FF(second)

  mov 0x8(%ebp), %ebp
  mov %eax, (%ebp)

  pop %ebx
  mov %ebp, %esp

  ret
