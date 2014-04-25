//============================================================================
// Name        : map_int_to_function_cxx11.cpp
// Author      : Ray
// Version     :
// Copyright   : Ray
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
#include <unordered_map>
#include <functional>
#include <stdint.h>
#include <stdint-gcc.h>

using namespace std;

int func1()
{
	cout << "func1 called" << endl;
	return 1;
}

int func2(int arg)
{
	cout << "func2 called, arg is " << arg << endl;
	return 2;
}

class A
{
public:
	int member_func1() {
		cout << "member func1 called." << endl;
		return 3;
	}
	void member_func2(float g) {
		cout << "member func2 called, arg is " << g << endl;
	}
};


int main() {
//	cout << "Ray" << endl; // prints Ray

	// unordered_map<int, function> disp;
	//
	// http://www.cplusplus.com/reference/functional/function/
	// template <class T> function;     // undefined
	// template <class Ret, class... Args> class function<Ret(Args...)>;
	//
	// Raymond: function is template class, so cannot put in map directly
	//

//
//	unordered_map<int, intptr_t> disp;
//	disp.emplace(1, (intptr_t) func1 );
//	disp.emplace(2, (intptr_t) func2 );
////	disp.emplace(1, (intptr_t) &A::member_func1 );
////	function<int> c1;
////	function<int,int> c1;
//	function<void()> callc;
//
//	unordered_map<int, function<void()> > dispf;
////	dispf.emplace(1, )
//

	return 0;
}
