#include<stdio.h>
#include<stdlib.h>

struct test{
	int a;
	int b;
	char *c;
};


int main(){
struct test t = {0, 0, "ffdasdfasdfasasf"};
printf("%d", t.a);
return 0;
}
