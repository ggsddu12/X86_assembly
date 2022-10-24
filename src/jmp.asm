[org 0x7c00]  ;程序从0x7c00开始

mov ax, 3
int 0x10 ;将显示模式设置为文本

xchg bx, bx

mov ax, 0
mov cx, 100
start:
;     jmp short start  ;EB FE FE=1111_1110 =-2 ; jmp CS-2
;     jmp near 12345
;     jmp 0x0:0x7c00
     add ax, cx
     sub cx, 1
     jz end
     jmp start
    

end:
 

mov ax, 5
mov bx, 5
cmp ax, bx ;sub ax, bx  -> flag
;jcc
xchg bx, bx

halt:
    jmp halt

; times 510 - ( $ - $$ ) db 0
; db 0x55, 0xaa