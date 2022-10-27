#include<stdio.h>
// typedef struct struct_t
// {
//     char c1;   //1B
//     short s1;  //2B
//     int i1;    //4B
// } struct_t;
// struct_t data;
// typedef struct struct_t
// {
//     char c1;
//     int i1;
//     char c2;
//     int i2;
//     char c3;
//     int i3;
// } struct_t;

// typedef struct struct_t
// {
//     int i1;
//     int i2;
//     int i3;

//     char c1;
//     char c2;
//     char c3;
// } struct_t;

// struct_t data;

// typedef enum enum_t
// {
//     ENUM1 = 1,
//     ENUM2,
//     ENUM3
// } enum_t;

// enum_t edata = 345;

typedef union test{
    int value;
    unsigned int uvalue;
}TEST;

int main(){
    TEST a;
    a.value=10;
    printf("%u\n",a.uvalue);
}