#include <stdio.h>

struct A {
  int val;
};

struct R {
  int& valr;
};

struct AR{
  int  vala;
  int& valra = vala;
};

struct ABRR {
  int  vala;
  int  valb;
  int& valra = vala;
  int& valrb = valb;
};

struct ARBR {
  int  vala;
  int& valra = vala;
  int  valb;
  int& valrb = valb;
};

struct ABCRRR {
  int  vala;
  int  valb;
  int  valc;
  int& valra = vala;
  int& valrb = valb;
  int& valrc = valc;
};

struct ARBRCR {
  int  vala;
  int& valra = vala;
  int  valb;
  int& valrb = valb;
  int  valc;
  int& valrc = valc;
};


int main()
{
  printf("sizeof(int) = %d \n", sizeof(int));       // 4
  printf("sizeof(int&) = %d \n", sizeof(int&));     // 4
  printf("sizeof(int*) = %d \n", sizeof(int*));     // 8
  printf("sizeof(A) = %d \n", sizeof(A));           // 4
  printf("sizeof(R) = %d \n", sizeof(R));           // 8
  printf("sizeof(AR) = %d \n", sizeof(AR));         // 16
  printf("sizeof(ABRR) = %d \n", sizeof(ABRR));     // 24
  printf("sizeof(ARBR) = %d \n", sizeof(ARBR));     // 32
  printf("sizeof(ABCRRR) = %d \n", sizeof(ABCRRR)); // 40
  printf("sizeof(ARBRCR) = %d \n", sizeof(ARBRCR)); // 48
  // conclusion, & (reference) has cost, not cheap.
}


