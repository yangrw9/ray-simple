#include <stdio.h>

struct A
{
static void Foo();
void Bar();
};

void A::Foo()
{
  printf("A::Foo() called\n");
}

void A::Bar()
{
  printf("A::Bar() called\n");
}

int main()
{
  auto p = &A::Foo;
  p();

  A a;
  auto q = &A::Bar;
  (a.*q) ();  //  operator .*    // operator ->*  
}
