#include <stdio.h>
#include <math.h>

struct plane_xy {
  double x;
  double y;
};

struct plane_12 {
  double coord1;
  double coord2;
};


template<typename T >
double point_distance(const T& a, const T& b)
{
  double diff_coord1 = a.coord1 - b.coord2;
  double diff_coord2 = a.coord2 - b.coord2;
  double distance = hypot(diff_coord1, diff_coord2);
  return distance;
}

double point_distance(plane_xy& a, plane_xy& b)
{
  plane_12* ren_a =  (plane_12*)&a;
  plane_12* ren_b =  (plane_12*)&b;
  return point_distance(*ren_a, *ren_b);
}

//template<typename TO, typename FROM>
//TO alias_cast

int main()
{
  plane_xy a = {0, 0};
  plane_xy b = {1, 1};
  
  double dis = point_distance(a,b);
  printf("Distance %f \n", dis);
}
