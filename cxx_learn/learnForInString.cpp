#include <stdio.h>
#include <string>

// C++11 helper, we are waiting for C++14
// user-defined literal should begin with _
// no _ prefix is for standard. (inverse identify conversion)
std::string operator "" _s(const char * str, size_t len)
{
  return std::string(str, len);
}

int main()
{
  printf("iterate string lieral\n");
  for(char c: "abc") {
    printf("%c\n",c);  // will print terminated NULL char
  }
  printf("====\n");

  printf("iterate std::string \n");
  for(char c: std::string("abc") ) {
    printf("%c\n",c);  // no terminated NULL
  }
  printf("====\n");

  printf("iterate user-defined literal (as std::string)\n");
  for(char c: "abc"_s ) {
    printf("%c\n",c);
  }
  printf("====\n");

}

