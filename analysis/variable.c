
#include <stdio.h>

// int a;
// int b =0;
// int c = 5;
// static int d = 8;
// static const int e =10;
// int array[5];
// int iarray[]={1,2,3,4,5};
// char message[]="hello,world\n";


int add(int a, int b)
{
    int c = a + b;
    return c;
}

int main()
{
    int i = 5;
    int j = 10;
    int k = add(i, j);
    printf("%d + %d = %d\n", i, j, k);
    return 0;
}
