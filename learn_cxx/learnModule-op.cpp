#include <stdio.h>
#include <math.h>

int main()
{
  // ￥ 向 零 填洞    (英文他们在说 rounded towards zero) 
  //   Module 操作的含义：所有整数部分视为等同， 即 零
  //   （就 C++代码行为来干）
  //
  printf("-6 % 3 = %d \n", -6 % 3);  // 0
  printf("-7 % 3 = %d \n", -7 % 3);  // -1
  printf("-8 % 3 = %d \n", -8 % 3);  // -2
  printf("-9 % 3 = %d \n", -9 % 3);  // 0

  printf("  5.3 %  2   = %f \n", fmod(5.3, 2) );   // 1.3
  printf(" -5.3 %  2   = %f \n", fmod(-5.3, 2) );  // -1.3
  printf("  5.3 % -2   = %f \n", fmod(5.3, -2) );  // 1.3
  printf(" -5.3 % -2   = %f \n", fmod(-5.3, -2) ); // -1.3
  

  printf("  5.3 %  2.1 = %f \n", fmod(5.3, 2.1) );   // 1.1
  printf(" -5.3 %  2.1 = %f \n", fmod(-5.3, 2.1) );  // -1.1
  printf("  5.3 % -2.1 = %f \n", fmod(5.3, -2.1) );  // 1.1
  printf(" -5.3 % -2.1 = %f \n", fmod(-5.3, -2.1) ); // -1.1

}

