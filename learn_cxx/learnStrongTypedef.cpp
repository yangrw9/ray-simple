#include <stdio.h>

template<class T, int typeuid>
struct StrongTypedef
{
  enum {TypeUid = typeuid};
  typedef StrongTypedef<T, typeuid> ThisType;  
  typedef T PrimaryType;
  PrimaryType value;

public:
  explicit StrongTypedef(PrimaryType v) : value(v){}
  StringTypedef() value() {}

  explicit operator PrimaryType() {return value;}  

// Oh,... no...
  operator + (ThisType o);
  operator - (ThisType o);
  operator * (ThisType o);
  operator / (ThisType o);

};

typedef StringTypedef<int, 0>    bint;
typedef StrongTypedef<double, 1> bfloat;

//operator "" _axis
int main()
{
}
