
// g++-4.8 -std=c++11 learnInitilizeList.cpp 

#include <stdio.h>

#include <initializer_list>
#include <algorithm>
#include <array>

bool is_in(int val, std::initializer_list<int> list)
{
	auto found = std::find(list.begin(), list.end(), val);
	return found != list.end();
}

/* gcc 4.4  -- <array> is a working draft
template<size_t size>
bool is_in_array(int val, const int (&list)[size], int* index)
{
	const int *const begin = &list[0];
	const int *const end =  begin + sizeof(list)/sizeof(list[0]);
    auto found = std::find(begin, end, val);
    if (found != end) {
    	index ? *index= found-begin : 0;
    	return true;
    } else {
    	return false;
    }
}
*/

template<size_t size>
bool is_in_array(int val, const int (&list)[size], int* index)
{
    auto found = std::find(std::begin(list), std::end(list), val);
    if (found != std::end(list)) {
    	index ? *index= found - std::begin(list) : 0;
    	return true;
    } else {
		index ? *index = -1 : 0;
    	return false;
    }
}


int main()
{
	bool in1;
	in1 = is_in(1, {12, 13, 14});
	printf("is_in(1, {12, 13, 14})  : %d \n", in1);

	int index;

//	in1 = is_in_array(1, {99, 98, 1,2,3}, &index); // couldn't deduce 
//	in1 = is_in_array(1, reinterpret_cast<const int[]>({99, 98, 1,2,3}), &index); //  expected primary-expression before  ‘{’ token
//	in1 = is_in_array(1, static_cast<const int[]>({99, 98, 1,2,3}), &index);  //  expected primary-expression before  ‘{’ token
//	in1 = is_in_array(1, dynamic_cast<const int[]>({99, 98, 1,2,3}), &index);  //  expected primary-expression before  ‘{’ token
//	in1 = is_in_array(1, const int[]{99, 1,2,3}, &index);  // expected primary-expression before ‘const’
//	in1 = is_in_array(1, const int[]({99, 1,2,3}), &index); // xpected primary-expression before ‘const’

//  [n3242] C++11 final-draft-before-std
//  5.2.3 Explicit type conversion (functional notation) [expr.type.conv]
//
//  Similarly, a simple-type-speciﬁer or typename-speciﬁer followed by a braced-init-list creates a temporary
//  object of the speciﬁed type direct-list-initialized (8.5.4) with the speciﬁed braced-init-list, and its value is
//  that temporary object as a prvalue.
//

	in1 = is_in_array(2, (const int[]){99, 1,2,3}, &index);
	printf("is_in(int, int[], int* index) : %d  (at index %d) \n", in1, index);


}
