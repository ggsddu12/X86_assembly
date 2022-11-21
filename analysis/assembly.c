#include <stdio.h>

int a = 10;
int b = 20;
int result;
int main()
{
    // int a = 10;
    // int b = 20;
    // int result = 30;

    // asm("movl a, %eax\n");
    // asm("movl b, %edx\n");
    // asm("addl %edx, %eax\n");
    // asm("movl %eax, result");
    // result = a + b;
    asm volatile(
        "movl $10, %0\n"
        "movl $20, %1\n"
        : "=&r"(a) // %0
        : "r"(b));

    printf("%d + %d = %d\n", a, b, result);
}