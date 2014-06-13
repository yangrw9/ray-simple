#include <stdio.h>

#include <functional>

// awareness of 'Type of Function', explicit

typedef void Fun (int);		// Syntax-1
typedef void (*FunP) (int);

//using Func  = void(int);	// Syntax-2   // C++11 
//using FuncP = void(*) (int);	// C++11 

//template<typename T, typename F = void(T)> // Syntax-3   // C++11
//void foo(T a)
//{
//}

template<typename T, typename F = void(T)> // Syntax-4 
struct A 
{
 
};

// Applying of Exit lib
// Qt


int main()
{
// foo(1);

//int a = 1;
 //foo(a);
 
 A<int> a;
 
}