
#include <stdio.h>

//void printArraySize(int* a);    // sizeof(a) == 4  obvious no sizeof

//void printArraySize(int a[20]) // sizeof(a) == 4  not expected, equals to pointer

//void printArraySize(int (&a)[20]) // sizeof(a) = 4 * 20 expected, but can only accept int[20], no int[15] etc.

void printArraySize(int a[20]) 
{
	printf("sizeof(a[]): %d\n", sizeof(a));
}

template<int size>
void printArraySizeT( int (&a)[size])  // work as expected, for int[any_size]
{
	printf("sizeof(a[]): %d\n", sizeof(a));
}

int main()
{
	int x[15];
    int y[16];
	printArraySize(x);
	printArraySizeT(y);
}
