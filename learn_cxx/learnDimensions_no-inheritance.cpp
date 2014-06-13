
#include <stdio.h>

// do NOT like inheritance. Why simple object needs simpler?
struct Coord1D 
{
  double x;
};

struct Coord2D 
{
  double x;
  double y;
};

struct Coord3D
{
  double x;
  double y;
  double z;
};

//template<class From, class To>
//To& treat_as(From&);

Coord2D& treat_as(Coord3D& value)
{
  Coord2D * p = reinterpret_cast<Coord2D*>( &value );
  return *p;
}

int main()
{
  Coord3D b = {1, 2, 3};
  
  Coord2D v;
  v = treat_as(b);
  
  printf("Coord2D {%f, %f} \n", v.x, v.y);
}