#include<stdio.h>
#include<stdint.h>

int main(){
  int16_t i = 0xb;
  int16_t j = 0x2;
  printf("%x\n", i%j);
  return 0;
}
