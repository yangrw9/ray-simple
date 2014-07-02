#include <stdio.h>

inline
constexpr int index_of(char c, char k) {
  return k == c ? 0 : -1;
}


template<typename... T>
inline
constexpr int index_of(char c, char k, T... others) {
  return k == c ? sizeof...(others) : index_of(c, others...);
}


template<typename... T>  // must be template
constexpr int index(char c, T... others)
//template<> 
//constexpr int index(char c, char... others)   // not accept
{
    //
    //   1 2 3 4  5      // sizeof...(others) - index_of(c, others...)
    //   3 2 1 0 -1      // index_of(c, others...)
    //   a b c d
    //       ^
    //
    // index_of(c, others...)                       Found will be          逆序号，序号从 0 开始  reversed
    //                                              Not found will be      -1
    //
    // sizeof...(others) - index_of(c, others...)   Found will be          正序号，序号从 1 开始
    //                                              Not found will be      sizeof...(others) + 1.
    // 
    // Following expression is used to shift 'Not Found' to -1, 'Found' is unmodified.
    //
   return ( sizeof...(others) - index_of(c, others...) ) % (sizeof...(others) + 1) - 1;
}

int main()
{
  // http://thenewcpp.wordpress.com/2011/11/29/variadic-templates-part-2/
  //
  
//   int c = index_of<'a', 'b', 'c', 'n'>  ('a');
//   printf("i = %d \n", c);  // 0

   printf("i = %d \n", index('a', 'a', 'b', 'c', 'n') );  // 0
   printf("i = %d \n", index('c', 'a', 'b', 'c', 'n') );  // 2
   printf("i = %d \n", index('n', 'a', 'b', 'c', 'n') );  // 3
   printf("i = %d \n", index('k', 'a', 'b', 'c', 'n') );  // -1
   
}

/*
 学习收获：
   Variadic template 让不确定个数的参数，每个不确定参数 都有自己的类型。
   
   此能力要通过模板获得。
   
   上例中，我们想要一个参数类型都一样，只是个数不确定的函数调用。
   用 Variadic template 似乎有点过，怎么保证不确定个数的参数都是一个类型？
   
   函数可变参模板这样用，似乎做不到。
   
   注： 定义成 constexpr 是因为在其他地方需要在 static_assert 时使用
 
 参考：
  http://en.wikipedia.org/wiki/Variadic_templates
 
*/
