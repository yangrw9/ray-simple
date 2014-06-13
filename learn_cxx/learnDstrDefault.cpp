#include <stdio.h>


class A 
{
protected:
 virtual ~A() = default;
};

class B : public A
{
public:
 virtual ~B() = default;
};

int main()
{
 B b;
}

