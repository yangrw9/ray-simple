
#include <iostream>

enum class Side
{
  Null = 0,
  Left = 1,
  Right = 2,
};

// http://stackoverflow.com/questions/2393439/can-i-overload-operators-on-enum-types-in-c
//   Yes, operator overloading can be done on enum and class types. 
//
bool operator !(Side s) {
   return s != Side::Null;
}

// http://stackoverflow.com/questions/12753543/is-it-possible-to-manually-define-a-conversion-for-an-enum-class
//   No, it's not. Actually, an enum class is no class at all. 
//   The class keyword is only used because suddenly changing the unscoped enum to a scoped enum would have mean reworking all enums codes. 
//
// // C++ syntax memo
// class B
// {
// };
// 
// class A {
// public:
//   operator B()  // b = (B) a; // will call this type converstion operator
//   {
//   }
// };

int main()
{
 Side s = Side::Left;
// bool b = !s;

 using namespace std;
 cout << "opeator! (Side) = " << !s << endl;

 if (!!s) // !! idiom of C++, to use any type in 'bool' place: First operator! to bool, then ! on bool 
 {
   cout << "Side pass test" << endl;
 }

 
}
