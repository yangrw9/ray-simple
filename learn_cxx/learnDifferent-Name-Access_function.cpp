

using Coord = double&(*)(T&p);

// http://stackoverflow.com/questions/2447458/default-template-arguments-for-function-templates
// It said 'access = ' syntax is since C++11  (really ??)
template<typename T, 
         Coord coord1 = default_access<T>::coord1,
         Coord coord2 = default_access<T>::coord2 >  // Style-1 (type deduce)
double point_distance(const T& point_a, const T& point_b)
{
  double diff_coord1 = coord1(a) - coord1(b);
  double diff_coord2 = coord2(a) - coord2(b);
  double distance = hypot(diff_coord1, diff_coord2);
  return distance;
}



