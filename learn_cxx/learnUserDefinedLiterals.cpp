#include <stdio.h>
//#include <array>
#include <vector>
#include <stdexcept>

//http://en.wikipedia.org/wiki/C++11#User-defined_literals

// string literals can be processed only in cooked form
// There is no alternative template form

enum class Axis : char{
  X ,
  Y ,
  Z ,
  A ,
  B ,
  C ,
  U ,
  V ,
  W ,
};

std::vector<char> operator "" _axis(const char * string_values, size_t num_chars) 
{
  std::vector<char> v;
  printf("length is %d \n", num_chars);
  return std::move(v);
}

inline
Axis as_axis (char c)
{
  switch(c) {
    case 'x' : return Axis::X;
    case 'y' : return Axis::Y;
    case 'z' : return Axis::Z;
    case 'a' : return Axis::A;
    case 'b' : return Axis::B;
    case 'c' : return Axis::C;
    case 'u' : return Axis::U;
    case 'v' : return Axis::V;
    case 'w' : return Axis::W;
    default:
      throw std::out_of_range("Not a valid axis name");
  }
}

operator Axis(char c) {
  return as_axis(c);
}

// 'a'_axis
inline
Axis operator "" _axis(const char c)
{
  switch(c) {
    case 'x' : return Axis::X;
    case 'y' : return Axis::Y;
    case 'z' : return Axis::Z;
    case 'a' : return Axis::A;
    case 'b' : return Axis::B;
    case 'c' : return Axis::C;
    case 'u' : return Axis::U;
    case 'v' : return Axis::V;
    case 'w' : return Axis::W;
    default : throw std::out_of_range( std::string("Not a valid index ") += c );
  }
}



int main()
{
  "abc"_axis;
 'x'_axis;
// char a = 'y';
//  a _ax;
}
