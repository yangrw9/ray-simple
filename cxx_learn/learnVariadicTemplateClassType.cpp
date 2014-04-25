#include <iostream>
#include <stdio.h>

#include <algorithm>
#include <initializer_list>
#include <stdexcept>
#include <utility>

// http://thenewcpp.wordpress.com/2011/11/23/variadic-templates-part-1-2/

////////////////////////////////////////////////////////////////////
// 
template<char ...>
struct find_index_t;

template<char current>
struct find_index_t<current> {
  size_t operator()(char c) {
    return c == current ? 0 : -1;
  }
};

template<char current, char...others>
struct find_index_t<current, others...>
{
//  static const int result = 
//        c == current ? sizeof...(others)
//        : (sizeof...(others) > 0 
//           ? find_index_t<others...>::result 
//           : -1);
  size_t operator()(char c) {
     return c == current ? sizeof...(others) : find_index_t<others...>()(c);  
  }
};
//
//////////////////////////////////////////////////////////////////

template <typename T, char current, char ... others>
class TinyFixMap
{
  T values[sizeof...(others) + 1] = {};

public:
  T& operator[](char c) {
    int i = find_index_t<current, others...>()(c);
    if ( i != -1)  {
       return values[i];
    } 
    else {
       std::string str("Not a valid index ");
       throw std::out_of_range(str + c);
    }
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

}

//template <typename T, char current, char ... others>  // forward declare
//class TinyFixMap;


#if 0
/////////////////////////////////////////////////////////////////////////
// function overload
template <char current>
size_t get_index(char c) {
  return c == current ? 0 : -1;
}
template <char current, char ... others>
size_t get_index(char c) {

  return c == current ? sizeof ... (others) : get_index<others...>(c);
}
#endif 

/////////////////////////////////////////////////////////////////////////
/*
template <typename T, char current>
class TinyFixMap<T, current>
{
  T val[1];
  int as_index(char c) {
    return c == current ? 0 : -1;
  }
};
*/

#if 0
//////////////////////////////////////////////////////////////////////////
// function template specialize (not function overload)
//
// 一般式，对 N 成立(之形式)
//template <char ... T>
//size_t find_index(char);

// 特殊式，对 1 成立
//template <char current>
//size_t find_index(char c)
//{
  //return c == current ? 0 : -1;
//  return -1;
//}

// Expaned for N + 1
template <char current, char... others>
size_t find_index (char c)
{
  size_t index = sizeof...(others);
  if (index == 0) {
   return c == current ? index : -1;
 }
 // else if (index == 1) {
 // }
  else {
    return find_index<others...>(c);
  }
//  return c == current ? index : find_index<others...>(c);//(index == 0 ? -1 : find_index<others...>(c));
}
#endif
//
/////////////////////////////////////////////////////////////////////////
  //typedef typename TinyFixMap<T, others...> next;

//  int as_index(char c) {
   // return c == current ? 0 : nt::as_index(c);


 //: TinyFixMap<T, others...>

//template <typename T, char index, char ... others>


#if 0
template <typename... Args>
struct find_biggest;
 
//the biggest of one thing is that one thing
template <typename First>
struct find_biggest<First>
{
  typedef First type;
};
 
//the biggest of everything in Args and First
template <typename First, typename... Args>
struct find_biggest<First, Args...>
{
  typedef typename find_biggest<Args...>::type next;
  typedef typename std::conditional
  <
    sizeof(First) >= sizeof(next),
    First,
    next
  >::type type;
};


//  TinyFixMap<double, "abc"> var;
//  printf("var['a'] = %f \n", var['a']);
#endif 

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

#if 0
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
};
#endif


