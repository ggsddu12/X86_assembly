[org 0x7c00]  ;程序从0x7c00开始

mov ax, 3
int 0x10 ;将显示模式设置为文本

xchg bx, bx


mov ax, 0
mov ds, ax
mov ss, ax
mov sp, 0x7c00

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;注册中断向量
;0x80软中断，使0x80中断处的CS:IP指向print
;中断向量： offset(2B):CS(2B)
mov word[0x80*4], print  ;偏移 ,一个中断向量长4B，实际地址*4
mov word[0x80*4 + 2], 0  ;段地址
int 0x80 ; call 0:print

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;重新注册0号中断
mov word[0x0*4], divide_error  ;偏移 ,一个中断向量长4B，实际地址*4
mov word[0x0*4 + 2], 0  ;段地址
;内中断除零异常，触发0号中断，转到手动注册的中断服务例程divide_error处理
mov dx, 0
mov ax, 0
mov bx, 0
div bx       ;触发除0异常
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

halt:
    hlt; 关闭CPU 等待外中断到来
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
     iret

divide_error: ;在屏幕上输出字符/
     push ax
     push bx
     push es 
     mov ax, 0xb800
     mov es, ax
     mov bx, [video]
     mov byte[es:bx], '/'
     add word[video], 2
     pop es
     pop bx
     pop ax
     iret

video:
    dw 0x0

xchg bx, bx

; times 510 - ( $ - $$ ) db 0
; db 0x55, 0xaa