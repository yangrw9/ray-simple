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
  A a;
  a.Foo();
  a.Bar();
  
//  a::Foo(); // invalid syntax.  ‘a’ is not a class or namespace

}