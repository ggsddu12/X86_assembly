#include<stdio.h>
int main(){
    int sum =0;
    int count =10;
    int b=0;
    // for(int i = 1; i< 10 ; i++ )
    //    sum+=i;

    // int count =10;
    while (count--)
    {
        b++;
        sum += count;   
    }
    // int count =10;
    // int b=0;
    // do{
    //     b++;
    //     sum+=count;
    // }while(--count);
    printf("%d %d\n",sum, b);
    return 0;
}