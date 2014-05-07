//============================================================================
// Name        : HelloCxx11.cpp
// Author      : Ray
// Version     :
// Copyright   : Ray copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
#include <functional>

using namespace std;

void foo()
{
	cout << "Hello foo foo foo." << endl;
}

struct dumb
{

};

struct A
{
	int aa;
};

struct B
{
	int bb;
};

template<class T>
struct C
{
	T;
};

struct D
{
	struct A;
};

// Raymond:
// Question: assemble struct dynamicly, accroding template param
int main() {
	D ff;
	ff.aa;

	auto bb = std::bind(foo);
	bb();

	cout << "Hello World 11" << endl; // prints Hello World 11
	return 0;
}
