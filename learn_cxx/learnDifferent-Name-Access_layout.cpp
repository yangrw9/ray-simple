#include <stdio.h>

struct coord_xyz {
  double x;
  double y;
  double z;
};

struct coord_123 {
  double coord1;
  double coord2;
  double coord3;
};

// Tricky usage: switch base-plane to YZ
struct coord_yzx {
  double coord3; // x  
  double coord1; // y   // 1st in 'yzx' order
  double coord2; // z   
};

// Over tricky usage: same name, different meaning
struct coord_zxy {
  double y; // coord2   // (origin) x    
  double z; // coord3   // (origin) y    
  double x; // coord1   // (origin) z   // 1st in (origin) 'zxy' order 
};

void access_by_different_name()
{
  coord_xyz a = {2, 4, 8};
   
  // different name, same position
  coord_123* p =  reinterpret_cast<coord_123*>(&a);
  p->coord1 = 11;
  p->coord2 = 12;
  
  printf("123 plane_xyz { %f, %f, %f } \n", a.x, a.y, a.z);  // 11, 12, 8

  
  coord_yzx* q = reinterpret_cast<coord_yzx*>(&a);
  q->coord1 = 21;
  q->coord2 = 22;
  printf("yzx plane_xyz { %f, %f, %f } \n", a.x, a.y, a.z);  // 11, 21, 22

  coord_zxy* o = reinterpret_cast<coord_zxy*>(&a);
  o->x = 301;
  o->y = 302;
  printf("zxy plane_xyz { %f, %f, %f } \n", a.x, a.y, a.z);  // 302, 21, 301

}

int main()
{
  access_by_different_name();
}


