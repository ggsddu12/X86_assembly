[org 0x7c00]  ;程序从0x7c00开始

CRT_ADDR_REG equ 0x3d4
CRT_DATA_REG equ 0x3d5

CRT_CURSOR_HIGH equ 0x0e
CRT_CURSOR_LOW equ 0x0f


mov ax, 3
int 0x10 ;将显示模式设置为文本


mov ax, 0
mov ds, ax
mov ss, ax
mov sp, 0x7c00

xchg bx, bx
; mov ax ,1800 ;1800 ;22 * 80 + 40 (22,40);  0000_0111 0000_1000
; call set_cursor

xor ax, ax

mov ax, 0xb800
mov es, ax

mov si, message
mov di, 0
print:
    call get_cursor      ;获取光标位置
    mov di, ax
    shl di, 1

    mov bl, [si]
    cmp bl, 0
    jz print_end

    mov [es:di], bl      ;将字符写入光标位置
    inc si
    inc ax               ;光标位置后移1
    call set_cursor      ;设置光标
    jmp print

print_end:

halt:
     hlt ;关闭CPU，等待外中断
     jmp halt

set_cursor:
     push dx
     push bx 
     mov bx, ax;   
     mov dx, CRT_ADDR_REG
     mov al, CRT_CURSOR_LOW
     out dx, al        ;告诉VGA要设置cursor低8位

     mov dx, CRT_DATA_REG
     mov al, bl        ;cursor位置低8位
     out dx, al        ;   

     mov dx, CRT_ADDR_REG
     mov al, CRT_CURSOR_HIGH
     out dx, al

     mov dx, CRT_DATA_REG
     mov al, bh
     out dx, al

     pop bx
     pop dx
     ret
get_cursor:
     push dx

     mov dx, CRT_ADDR_REG
     mov al, CRT_CURSOR_HIGH
     out dx, al        ;告诉VGA要设置cursor高8位

     mov dx, CRT_DATA_REG
     in al, dx         ;al取高八位
     shl ax, 8         ;al置高8位

     mov dx, CRT_ADDR_REG
     mov al, CRT_CURSOR_LOW
     out dx, al        ;告诉VGA要设置cursor低8位

     mov dx, CRT_DATA_REG
     in al, dx         ;al取低八位
     
     pop dx
     ret


message:
     db "Hello, world!!", 0
times 510 - ($ - $$) db 0

db 0x55, 0xaa

xchg bx, bx
