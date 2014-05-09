
#include <type_traits>
#include <iostream>

template<typename T, bool alloc, char... indexers>
class DynamicStore
{
  typedef typename std::conditional<alloc, T [sizeof...(indexers)], T*>::type StorageType;
  StorageType value;
};

template<typename T, char... indexers>
class DynamicStore2
{
  typedef typename std::conditional< std::is_arithmetic<T>::value, T [sizeof...(indexers)],
                      typename std::conditional<std::is_pointer<T>::value, T,
                        typename std::conditional<std::is_array<T>::value, typename std::remove_all_extents<T>::type,
                         void //T /*typename std::add_lvalue_reference<T>::type*/ //typename std::enable_if<false, T>::type
                        >::type // is_array
                      >::type // is_pointer
                    >::type StorageType;
  StorageType value;
public:
//  DynamicStore2(StorageType val = StorageType() ) :value(val) {
    
//  }
};


int main() 
{
//  void bb;
  using namespace std;
  int val[8];

  DynamicStore<int, true, 'a', 'b', 'c'> a;
  cout << "sizeof(DynamicStore<int, true, 'a', 'b', 'c'>)  " << sizeof a << endl;

  DynamicStore<int, false, 'a', 'b', 'c'> b;
  cout << "sizeof(DynamicStore<int, false, 'a', 'b', 'c'>) " << sizeof b << endl;

  ///////////////////////

  DynamicStore2<int, 'a', 'b', 'c'> x;
  cout << "sizeof(DynamicStore2<int, 'a', 'b', 'c'>)  " << sizeof x << endl;

  DynamicStore2<int*, 'a', 'b', 'c'> y;
  cout << "sizeof(DynamicStore2<int*, 'a', 'b', 'c'>)  " << sizeof y << endl;
	
}

