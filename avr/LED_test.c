#include<avr/io.h>

void wait(){
  volatile int i = 0;
  for (i = 0; i < 3000; i++);
}


int main(void){
  volatile char *dir = "testtesttest";
  int switch_flag = 0;
  DDRC = 0x0;
  DDRC |= 0x04; // PC2 = LED

  while(1){
    //switch_flag = PINC;
    if( (PINC & 0x10) != 0x10 ) {
      PORTC = 0x4;
    }
    else{
      PORTC = 0x0;
    }
  }
}
