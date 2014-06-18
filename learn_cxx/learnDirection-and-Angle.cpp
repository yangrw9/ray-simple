#include <stdio.h>
#include <math.h>

template<double full = 2 * M_PIl>
struct angle // _in_radian 
{
  double value;
  angle operator-() 
  {
    value = full - value;
    return (angle) {value};
  }
};

// A - B = c   (1) // from A to B (direction), rotated c (angle)
// A - c = B   (2)
struct direction // _in_angle 
{
  double value;

  angle operator- (direction o) // (1)
  {
    return this->value - o.value;
  }

  direction operator- (angle a) // (2)
  {
    direction c = {value};
    c.value -= a.value;
    return c;
  }

/*
  // meaningless 
  direction operator+ (angle a) 
  {
    direction c = {value};
    c.value += a.value;
    return c;
  }
*/

};


int main()
{
}
