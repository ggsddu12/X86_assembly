;15 硬盘读写
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

;从磁盘将loader读到0x1000
mov edi, 0x1000
mov ecx, 2
mov bl, 4
call read_disk

xchg bx, bx
jmp 0x1000

read_disk:
   ;读硬盘
   ;edi - 存储内存位置
   ;ecx - 起始扇区
   ;bl - 扇区数量
    pushad ; ax, cx, dx , bx ,sp , bp ,si , di
    ;pusha 16位， pushad 32位

    mov dx, 0x1f2
    mov al, bl
    out dx, al; 设置扇区数量

    mov al, cl
    inc dx;0x1f3
    out dx, al; 起始扇区位置低8位

    shr ecx, 8
    mov al, cl
    inc dx;0x1f4
    out dx, al; 起始扇区中8位

    shr ecx, 8
    mov al, cl
    inc dx;0x1f5
    out dx, al;起始扇区高8位

    shr ecx, 8
    and cl, 0b1111
    inc dx;0x1f6
    mov al, 0b1110_0000
    or al, cl
    out dx, al


    inc dx;0x1f7
    mov al, 0x20
    out dx,al

    .check_read_state:
        nop
        nop
        nop

        in al, dx
        and al, 0b1000_1000
        cmp al, 0b0000_1000  ;准备完毕且不繁忙
        jnz .check_read_state

    xor eax, eax
    mov al, bl
    mov dx, 256
    mul dx; ax = bl * 256

    mov dx, 0x1f0
    mov cx, ax    

    .read_loop:
        nop
        nop
        nop
        in ax, dx
        mov[edi], ax
        add di, 2

        loop .read_loop
    
    popad
    ret

xchg bx, bx


; mov dx, 0x1f2
; mov al, 1
; out dx, al; 设置扇区数量

; mov al, 2

; inc dx;0x1f3
; out dx, al;

; mov al, 0

; inc dx;0x1f4
; out dx, al;

; inc dx;0x1f5
; out dx, al;

; inc dx;0x1f6
; mov al, 0b1110_0000
; out dx, al


; inc dx;0x1f7
; mov al, 0x30
; out dx,al
; write_loop:
;     nop
;     nop
;     nop
;     mov ax, [es:di]
;     out dx, ax
;     add di, 2
;     cmp di, 512
;     jnz write_loop


; mov dx, 0x1f7
; .check_write_state:
;     nop
;     nop
;     nop

;     in al, dx
;     and al, 0b1000_0000
;     cmp al, 0b1000_0000  ;准备完毕且不繁忙
;     jz .check_read_state
jmp $
times 510 - ($ - $$) db 0
db 0x55, 0xaa
