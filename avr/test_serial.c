#include <avr/io.h>
//#include <util/delay.h>

int main(void)
{

  unsigned char data[] = "Hello world";  //受信したデータを格納
  
  //unsigned char data[] = "a";  //受信したデータを格納
  int i = 0;
  DDRD = 0b11111100;       //portD : 0,1pin以外出力
  PORTD = 0b00000000;

  UBRR0H = 0x0;
  UBRR0L = 12;
  //UBRR0L = 0x67;

  UCSR0A = 0b00000000;    //受信すると10000000になる
                          //送信有効になると00100000になる

  UCSR0B = 0b00011000;    //送受信有効
  UCSR0C = 0b00000110;    //データ8bit
                          //非同期,パリティなし
                          //Stop 1bit
   
  while(1){
     //受信するまで待つ
    //while( !(UCSR0A & 0b10000000) );  //0ならループ
    //data = UDR0;  //受信したデータを格納

     //受信できたかを確認するために受信データを返す
     //送信できるまで待つ
   i = 0;
    while(data[i] != 0){
      while( !(UCSR0A & 0b00100000) );  //0ならループ
        UDR0 = data[i];  //受信したデータを送信
        i++;
    }
  }

  return 0;
}
