#include <stdio.h>

enum MODE {
  M_A,
  M_B,
  M_C,
};

struct A {
 int foo_;
 int& foo() {return foo_;}

 MODE bar_;
 MODE& bar() {return bar_;}
 MODE  bar() const {return bar_;}  // avoid spell error, this call will not be assignable

};

int main()
{
  A a{};

  printf("A.foo_ == %d \n", a.foo_); // 0
  a.foo() = 11;
  printf("A.foo_ == %d \n", a.foo_); // 11
  
  printf("A.bar_ == %d \n", a.bar_); 
  a.bar() = M_B;
  printf("A.bar_ == %d \n", a.bar_); // 1
  
  A* p = &a;
  p->bar() = M_C;
  printf("A.bar_ == %d \n", a.bar_); // 2
}

