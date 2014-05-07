#include <iostream>
#include <stdio.h>

#include <algorithm>
#include <initializer_list>
#include <stdexcept>

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

