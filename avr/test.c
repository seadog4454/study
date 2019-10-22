#include<avr/io.h>

int main(void){
  volatile char *test = "test";
  int i = 0;
  char k = 0;
  for(i = 0; i < 4; i++){
    k = test[i];
  }
}
