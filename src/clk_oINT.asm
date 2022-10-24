[org 0x7c00]  ;程序从0x7c00开始

PIC_M_CMD equ 0x20
PIC_M_DATA equ 0x21



mov ax, 3
int 0x10 ;将显示模式设置为文本


mov ax, 0
mov ds, ax
mov ss, ax
mov sp, 0x7c00

xchg bx, bx

mov word[8 * 4], clock   ;offset,时钟中断号8，
mov word[8 * 4 + 2], 0   ;段地址

xchg bx, bx
mov al, 0b1111_1110       ;0是打开，1是关闭
out PIC_M_DATA, al

sti ;中断允许 IF=1
;cli;


loopa:
    mov bx, 3
    mov al, 'A'
    call blink
    jmp loopa

clock:
;     xchg bx, bx
    push bx
    push ax
    mov bx, 4
    mov al, 'C'
    call blink
    mov al, 0x20     
    out PIC_M_CMD, al ;0x20中断处理完成  
    pop ax
    pop bx
    iret

blink:
     push es
     push dx 
     mov dx, 0xb800
     mov es, dx

     shl bx, 1
     mov dl, [es:bx]
     cmp dl, ' '
     jnz .set_space
     .set_char:
         mov [es:bx], al
         jmp .done
     .set_space:
         mov byte [es:bx], ' '
     .done:
         shr bx, 1
     
     pop dx
     pop es
     ret

times 510 - ($ - $$) db 0
db 0x55, 0xaa
