[org 0x7c00]  ;程序从0x7c00开始

mov ax, 3
int 0x10 ;将显示模式设置为文本

xchg bx, bx

mov ax, 0xb800
mov es, ax ;访问两块内存message和显示器，需要两个段地址，引入额外的段寄存器es

mov ax, 0
mov ds, ax

mov si, message
mov di, 0
mov cx, (message_end - message) ;循环计数

; mov al, [ds:si]
; mov [es:di], al         ;显示H

; mov al, [ds:si+1]
; mov [es:di+1], 11110000b  ;控制字符，高亮闪烁
; mov [es:di+2], al         ;显示e,es加2是没；两个字节显示一个字符
                            ;显示时每个被显示字节后包含一个控制字符

loop1:
     mov al, [ds:si]
     mov [es:di], al         ;显示H
    ; mov byte [es:di + 1],11110000b ;背景高亮显示
     inc si
     add di, 2

     loop loop1 ;cx=0时结束循环

message:
     db "Hello, world!!", 0
message_end:



halt:
     jmp halt

times 510 - ($ - $$) db 0

db 0x55, 0xaa

xchg bx, bx
