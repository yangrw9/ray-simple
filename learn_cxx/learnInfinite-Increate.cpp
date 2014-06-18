#include <stdio.h>

//  --+-->
//    +---->
template<int wrap = 60, int split_zone= 2>
struct infinite {
  int value;
  
  // latest;
  // current;
  // 
  infinite operator+ (int v);
  {
     value += v;
     if (value >= 60 ) {
        value -= wrap;	// value %= warp;
     }
  }

  bool isValidIncreate (double new_value)
  {
     //new_value %= wrap; // (-wrap, wrap)

     if (new_value < value ) new_value += warp;
     distance = new_value - value;
     congate = wrap - distance;
     
     bool valid = (distance > 0) && (congate > distance);
     return valid;
  }

};

int main()
{
}

