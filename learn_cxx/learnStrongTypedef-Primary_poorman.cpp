#include <stdio.h>

struct Turn {
  int value;
  
};

struct Angle {
  int value;
  
  // http://en.wikipedia.org/wiki/C%2B%2B11#Modification_to_the_definition_of_plain_old_data
   // Are we still POD?  maybe standard-layout POD or trivial ?
   
  explicit Angle(int v) : value(v) {}  // for 13 , will no 11, 14
};

int foo(Turn v)
{
  printf("The Turn value %d \n", v.value);
}

int foo(Angle v)
{
  printf("The Angle value %d \n", v.value);
}

int main()
{
  //Turn t {11}; // error: could not convert ‘13’ from ‘int’ to ‘Turn’
  Turn t = {11};

  foo(t);
  
//  foo( 13 );       // error: could not convert ‘13’ from ‘int’ to ‘Turn’
  foo( (Turn)13 ); // error: no matching function for call to ‘Turn::Turn(int)’

  // g++ (Debian 4.8.2-21) 4.8.2

  foo( {14});        // warning: extended initializer lists only available with -std=c++11 or -std=gnu++11 [enabled by default]
  foo( Turn{14} );   // warning: extended initializer lists only available with -std=c++11 or -std=gnu++11 [enabled by default]
  
  foo( (Turn){14} ); // What's this in C++11 stdandard?
  
  
//  Angle a = {201};
}

