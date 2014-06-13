#include <stdio.h>
#include <math.h>

struct plane_xy {
  double x;
  double y;
};

/*
//template<typename T, const T& p> //
template<typename T>
struct Accessor{
  T* p;  // pointer is better then reference ??
  /*static*/ double coord1() { return p->x;}  // No Way static
  /*static*/ double coord2() { return p->y;}
};
*/

template<typename T>
struct Accessor{
  T* p;  // pointer is better then reference ??
  double coord1() { return p->x;}  // never be static
  double coord2() { return p->y;}
};

/*
template<class T>
Accessor<T> get(const T& p) // -> Accessor<T, p>
{
  return Accessor<T> = {p};
}
*/

template<typename T >
double point_distance(Accessor<T> a, Accessor<T> b)
{
  double diff_coord1 = a.coord1() - b.coord2();
  double diff_coord2 = a.coord2() - b.coord2();
  double distance = hypot(diff_coord1, diff_coord2);
  return distance;
}

template<typename T>
double point_distance(T& point_a, T& point_b)
{
  Accessor<T> a = {&point_a};
  Accessor<T> b = {&point_b};
  return point_distance(a, b);
}



int main()
{
  plane_xy a = {0, 0};
  plane_xy b = {1, 1};
  
  double dis = point_distance(a,b);
  printf("Distance %f \n", dis);
}