#include <stdio.h>

int main()
{
    char normal_str[] = "First line.\nSecond line.\nEnd of message.\n";
    char raw_str[] =R"(First line.\nSecond line.\nEnd of message.\n)";
    
    printf("NORMAL STRING:\n%s \n ", normal_str);
    printf("RAW STRING:\n%s \n ", raw_str);
    
    return(0);
}

// http://solarianprogrammer.com/2011/10/16/cpp-11-raw-strings-literals-tutorial/
