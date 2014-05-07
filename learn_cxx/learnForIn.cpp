#include <stdio.h>
#include <initializer_list>

int main()
{
  printf("for(char c: \"xyzabcuvw\") \n");
  for(char c: "xyzabcuvw") 
  {
    printf("Current: %c \n", c);  // will print ending NULL
  }

  printf("\n");
  printf("for(char c: {'x', 'y', 'z', 'a', 'b', 'c'})\n");
  for(char c: {'x', 'y', 'z', 'a', 'b', 'c'})
  {
    printf("Current: %c \n", c);
  }
  
  printf("\nfor(char c: list)\n");
  char list[] = {'x', 'y', 'z', 'a', 'b', 'c'};
  for(char c: list)
  {
    printf("Current: %c \n", c);
  }

}
