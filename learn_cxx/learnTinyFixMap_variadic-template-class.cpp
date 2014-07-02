#include <iostream>
#include <stdio.h>

#include <algorithm>
#include <initializer_list>
#include <stdexcept>

inline
constexpr int index_of(char c, char k) {
  return k == c ? 0 : -1;
}


template<typename... T>
inline
constexpr int index_of(char c, char k, T... others) {
  return k == c ? sizeof...(others) : index_of(c, others...);
}


template<typename... T>  // must be template
constexpr int get_index(char c, T... others)
//template<> 
//constexpr int index(char c, char... others)   // not accept
{
    //
    //   1 2 3 4  5      // sizeof...(others) - index_of(c, others...)
    //   3 2 1 0 -1      // index_of(c, others...)
    //   a b c d
    //       ^
    //
    // index_of(c, others...)                       Found will be          逆序号，序号从 0 开始  reversed
    //                                              Not found will be      -1
    //
    // sizeof...(others) - index_of(c, others...)   Found will be          正序号，序号从 1 开始
    //                                              Not found will be      sizeof...(others) + 1.
    // 
    // Following expression is used to shift 'Not Found' to -1, 'Found' is unmodified.
    //
   return ( sizeof...(others) - index_of(c, others...) ) % (sizeof...(others) + 1) - 1;
}


template <typename T, char... index>
class TinyFixMap 
{
  T vals[sizeof ...(index) ];
  int as_index(char c) {
    auto list = {index...};
    auto it = std::find(list.begin(), list.end(), c);
    return it != list.end() ? it - list.begin() : -1;
  }
  
  
public:
  T& operator[](char c) {
    int i = as_index(c);
    if ( i != -1)  {
       return vals[i];
    } 
    else {
       throw std::out_of_range("Not a valid index");
    }
  }
  
  template<char c>
  T&  m() {
    int i;
    static_assert( get_index(c, index...) != -1, "Not a valid index "); // how to print c in message?
    return vals[i];
  }
};

int main()
{
  TinyFixMap<double, 'a', 'b', 'c'> var;
  var['a'] = 10.2;
  var['b'] = 13;
  using namespace std;

  cout << "var['a'] = " << var['a'] << endl;
  cout << "var['b'] = " << var['b'] << endl;
  cout << "var['c'] = " << var['c'] << endl;
  cout << "var['d'] = " << var['d'] << endl;

  cout << "================" << endl;

//	  cout << "var['a'] = " << var.m<'a'>() << endl;
  var.m<'a'>();

}


//  TinyFixMap<double, "abc"> var;
//  printf("var['a'] = %f \n", var['a']);

#if 0
template <typename T, char index>
class TinyFixMap
{
protected:
  T val[1];

  int as_index(char c) {
    if (c == index) {
      return 0;
    } else {
      return -1;
    }
  }

public 
  T& operator[char c] {
    if ( as_index(c) !== -1 ) {
      return val[as_index(c)]
    } else {
      throw std::out_of_range();
    }
  }
}
template <typename T, char... index>
class TinyFixMap;
#endif
//    auto it = std::find(std::begin(index...), std::end(index...), c);
//    return it != std::end(index...) ? it - std::begin(index...) : -1 ;


// ? vals[as_index(c)] : vals[-1];

#if 0
template <typename T, char index, char ...nextIndex>
class TinyFixMap 
{

}

template <typename T, std::string Indexes>
class TinyFixMap2
{

};
#endif

