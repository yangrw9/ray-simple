#include <stdio.h>

#include <functional>

// 'Type of Function'

typedef void Fun (int);	      // Syntax-1  C++03 (name type likes variable declare) 
typedef void (*FunP) (int);   // Syntax-1a C++03 Lots libraries uses this to name type of function pointer

using Func  = void(int);      // Syntax-2  C++11 MOST clear!!! 
using FuncP = void(*) (int);  // Syntax-2a C++11 equivalence of Syntax-1a

template<typename T, typename F = void(T)> // Syntax-3 C++03 (tricky, ONLY way to name type in C++03)  
struct FuncCall
{
  typedef F type;
};


template<typename T, typename F = void(T)> // Syntax-3a  C++11 // only C++11 function template has default template param
void foo(T a)
{
  F* c;
}

struct A 
{
  void foo(int);
  void bar(int);
};
typedef void (A::*FunPA) (int); 
//typedef void (A:: FunA ) (int); // invalid syntax

using FuncAP = void(A::*) (int); 
//using FuncA = void(A:: ) (int); // invalid syntax


/////////////////////////////////////////////////////////////////////////
// Lots lib use 'Syntax-3'
//
// Examples:
//
// Applying of Exit lib
// Qt


int main()
{
 foo(1);

//int a = 1;
 //foo(a);
 
 FuncCall<int> a;
 
}


