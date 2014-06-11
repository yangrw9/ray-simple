#include <math.h>
#include <stdio.h>
//#include <utility>

/////////////////////////////////////////////////////////////////////////////
// 0) primary type
typedef double mtype;

/////////////////////////////////////////////////////////////////////////////
// 1) basic structure  (Various)
struct plane_point {
  double coord1;
  double coord2;
};

struct plane_xy {
  double x;
  double y;
};

/////////////////////////////////////////////////////////////////////////////
// Glues for 1 and 2  (basic structure VS basic algorithm)
//
// It's dirty!
//
////////////////////////////////////
// To wipe-off variance of 1
//
//
// Style-1  (function template, type parameter)
// Pros: Client is easy to use
// Cons: T may different
//struct plane_point_access{
//  template<typename T>
//  static double coord1(const T& p) { return p.coord1;}
//  template<typename T>
//  static double coord2(const T& p) {return p.coord2;}
//};
//// usage: 
// plane_point_access::coord1(p);  // type inferance

// Style-2 (class template, type parameter)
// Pros: T is treated as a whole, all assumption must be confirmed.
// Cons: Client has to supply type (C++11 template alias eases)
//template<typename T>
//struct plane_point_access{
template<typename T>
struct access_12{
  static double coord1(const T& p) { return p.coord1;}
  static double coord2(const T& p) {return p.coord2;}
};
//// usage: 
// plane_point_access<plane_point>::coord1(p);
//
//// C++11
// using ppa = plane_point_access<plane_point>;
// ppa::coord1(p);


// Style-3 (class template, non-type parameter)
//
//// http://stackoverflow.com/questions/5687540/non-type-template-parameters
//// template<plane_point p>   // not a valid type for a template non-type parameter
//
//template<plane_point* p>
//struct plane_point_access{
//  static double coord1() { return p.coord1;}
//  static double coord2() { return p.coord2;}
// }
//
//// usage: 
// plane_point_access<p>::coord1();

// Style-4 (function template, non-type parameter)
//struct plane_point_access{
//  template<plane_point* p>
//  static double coord1() { return p.coord1;}
//  template<plane_point* p>
//  static double coord2() { return p.coord2;}
// }
//// usage: 
// plane_point_access::coord1<p>();


template<typename T>
struct access_xy{
  static double coord1(const T& p) { return p.x;}
  static double coord2(const T& p) {return p.y;}
};

//////////////////////////////////////
// To help type inferance for 2
// It makes access trait selection automatic.
//
template<typename T>
struct default_access;

// Style-1 (just redirection)
// inferance implement (for 'plane_point')
template<>
struct default_access<plane_point>
{
  using type = access_12<plane_point>;
};

template<>
struct default_access<plane_xy>
{
  using type = access_xy<plane_xy>;
};

// Style-2 (inplace declare) 
// Pros:
// Cons: Can't reuse access method.
//
// inferance implement (for 'plane_xy')
//template<>
//struct default_access<plane_xy>
//{
//  typedef plane_xy T;
//  struct type{
//    static double coord1(const T& p) { return p.x;}
//    static double coord2(const T& p) {return p.y;}
//  };
//};


//
/////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////
// 2) basic algorithm  (Stable)
//   Note: Depends on constant assumptions. Here, we use access Trait.
//         http://en.wikipedia.org/wiki/Trait_(computer_programming)
//
//template<typename T, typename access>  // No way to infer 'access', client code will be tough, no no no...
//
// http://stackoverflow.com/questions/2447458/default-template-arguments-for-function-templates
// It said 'access = ' syntax is since C++11  (really ??)
template<typename T, typename access = typename default_access<T>::type>  // Style-1 (type deduce)
double point_distance(const T& point_a, const T& point_b)
{
  double diff_coord1 = access::coord1(point_a) - access::coord1(point_b);
  double diff_coord2 = access::coord2(point_a) - access::coord2(point_b);
  double distance = hypot(diff_coord1, diff_coord2);
  return distance;
}

// Style-2 (make alise)
// Pros:
// Cons: It's a totally wrong idea.
//
// http://stackoverflow.com/questions/9864125/c11-how-to-alias-a-function
//   You cannot alias functions.
//
//   Classes are types, so they can be aliased with typedef and using (in C++11).
//   Functions are much more like objects, so there's no mechanism to alias them. 
//   In the same vein, there's no mechanism for aliasing variables.
//
//using plane_point_distance = double point_distance<plane_point, plane_point_access>(const plane_point& point_a, const plane_point& point_b); // Not valid

// 
//double plane_point_distance(const plane_point& point_a, const plane_point& point_b)
//{
////  return point_distance<plane_point, plane_point_access>(point_a, point_b);
////    return point_distance<plane_point, plane_point_access>(std::forward(point_a), std::forward(point_b));
//}


/////////////////////////////////////////////////////////////////////////////
// 100) sample client code
void foo_use_ponit_dist()
{
  double dis;
  
  plane_point a = {0, 0};
  plane_point b = {1, 1};
  
  dis = point_distance(a,b);
  
  printf("Plane any Distance is %f\n", dis);
  
  ////////////////////////////
  
  plane_xy p1 = {0, 0};
  plane_xy p2 = {2, 2};
  
  dis = point_distance(p1, p2);	// Beautiful Life ... the harvest from previous code, 
  printf("Plane XY Distance is %f\n", dis);
  
}

// Additional Read (maybe help)
//
// http://en.wikipedia.org/wiki/Trait_(computer_programming)
//   a trait represents a collection of methods, that can be used to extend the functionality of a class ...
//   Traits are somewhat between an interface and a mixin: 
//     an interface is made only of method signatures, 
//     while a trait includes also the full method definitions, 
//     on the other side mixins include method definitions, but the can also carry state through attributes while traits usually don't.
//
// http://accu.org/index.php/journals/442
//   An introduction to C++ Traits
//
// http://www.cppblog.com/youxia/archive/2008/08/30/60443.html
//   理解模板编程中的Trait和Mataprogram
//

int main()
{
  foo_use_ponit_dist();
}