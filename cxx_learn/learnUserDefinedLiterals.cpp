#include <stdio.h>
//#include <array>
#include <vector>

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

int main()
{
  "abc"_axis;
}
