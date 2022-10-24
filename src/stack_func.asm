[org 0x7c00]  ;程序从0x7c00开始

mov ax, 3
int 0x10 ;将显示模式设置为文本

xchg bx, bx

; mov cx, 5
; loop1 :
;    call print
; loop loop1



call 0:print

halt:
    jmp halt

print: 
     push ax
     push bx
     push es 
     mov ax, 0xb800
     mov es, ax
     mov bx, [video]
     mov byte[es:bx], '.'
     add word[video], 2
     pop es
     pop bx
     pop ax
     retf

video:
    dw 0x0

xchg bx, bx

; times 510 - ( $ - $$ ) db 0
; db 0x55, 0xaa