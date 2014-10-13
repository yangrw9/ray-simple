#include <stdio.h>

struct Line
{
  double end_x;
  double end_y;
};

struct Arc
{
  double end_x;
  double end_y;
  double center_x;
  double center_y;
  int turns; // ccw [1, ...],  cw [... , -1], no arc 0,  full round = turns - 1 (in turn dir)
};

struct Move {
  int type;
  
  union U 
  {
    Line line;
    Arc arc;
  };
};


int use_anonymous() 
{
  Move m;
  m.line.end_x = 1;
}


int main()
{
  use_anonymous();
}