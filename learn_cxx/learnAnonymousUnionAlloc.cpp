#include <stdio.h>
#include <vector>

enum class Type 
{
  Null = 0,
  Line,
  Arc,
};

struct Base
{
virtual Type GetType() = 0;
};

struct Line : public Base
{
virtual Type GetType() override { return Type::Line; }

};

struct Arc : public Base
{
virtual Type GetType() override { return Type::Arc; }

};

struct All
{
 All() :type(Type::Null) {} // = default // is ill-formed
 All(Line line): type(Type::Line), line(line) {}
 All(Arc arc): type(Type::Arc), arc(arc) {}
 
 Type type;
 union  {
  Line line;
  Arc arc;
 } ;
 
 operator Base*()
 {
   return GetBase();
 }
 
 Base* GetBase()
 {
  if (line.GetType() == type) {
    return &line;
  } else if (arc.GetType() == type) {
    return &arc;
  } else {
    return nullptr;
  }
 }
};

// 1. 方法自动分派
// 2. 统一尺寸存储
// 3. 动态类型判定

int main()
{
 // All b;
  //All a {Type::Line, Line() };
  Line l;
  All a(l);
  Base* p;
  p = a;
  printf("Type is %d \n", p->GetType());
  
  std::vector<All> some;
  All c[10];
}