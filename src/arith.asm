[org 0x7c00]  ;程序从0x7c00开始

mov ax, 3
int 0x10 ;将显示模式设置为文本

xchg bx, bx

mov ax, 5
mov bx, 6
add ax, bx ;ax = ax + bx
add [number], 5
sub ax, bx ;ax = ax - bx

mov ax, 5
mov bx, 7
mul bx; dx : ax = bx * ax

mov bx, 4
div bx; 商 ax = （dx : ax） / bx， 余数 dx = （dx : ax ） % bx
      ; 35/4=8 ax = 8 35%4=3 dx = 3
 
clc; 进位清零
mov ax, [number1]
mov bx, [number2]
add ax, bx
mov [sum], ax

mov ax, [number1 + 2] ;高两个字节
mov bx, [number2 + 2]
adc ax, bx            ; ax = ax + bx + CF 进位加
mov [sum + 2], ax
;sbb借位减
halt:
    jmp halt

number:
    dw 0x3456

number1:
    dd 0xcfff_ffff
number2:
    dd 4
sum:
    dd 0x0000_0000



times 510 - ( $ - $$) db 0
db 0x55, 0xaa