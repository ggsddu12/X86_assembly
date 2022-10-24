[org 0x7c00]  ;程序从0x7c00开始

mov ax, 3
int 0x10 ;将显示模式设置为文本

mov ax, 0
mov ds, ax
mov ss, ax
mov sp, 0x7c00

xchg bx, bx

mov ax, 0x55aa ; 0b_0101_0101_1010_1010
mov bx, 0xaa55 ; 0b_1010_1010_0101_0101
and ax, bx

mov ax, 0x55aa ; 0b_0101_0101_1010_1010
not ax   ; 0xaa55    

mov ax, 0x55aa
or ax, bx; 0xffff

mov ax, 0xffff
xor ax, bx; 55aa

xor ax, ax ;寄存器清零

mov ax, 0b1111_0010
test ax, 0b0000_0010 ; dst src1 AND src2   use dst to set eflags
test ax, 0b0000_1000


halt:
    hlt ;
    jmp halt
xchg bx, bx
times 510 - ( $ - $$ ) db 0
db 0x55, 0xaa