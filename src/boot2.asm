[org 0x7c00]  ;程序从0x7c00开始

mov ax, 3
int 0x10 ;将显示模式设置为文本

xchg bx, bx


; mov ax, 0xb800
; mov ds, ax

; ;显示Hello,World!
; mov byte [0], 'H'
; mov byte [1], 11110000b
; mov byte [2], 'e'
; mov byte [3], 11110000b
; mov byte [4], 'l'
; mov byte [5], 11110000b
; mov byte [6], 'l'
; mov byte [7], 11110000b
; mov byte [8], 'o'
; mov byte [9], 11110000b
; mov byte [10], ','
; mov byte [11], 11110000b
; mov byte [12], 'W'
; mov byte [13], 11110000b
; mov byte [14], 'o'
; mov byte [15], 11110000b
; mov byte [16], 'r'
; mov byte [17], 11110000b
; mov byte [18], 'l'
; mov byte [19], 11110000b
; mov byte [20], 'd'
; mov byte [21], 11110000b
; mov byte [22], '!'
; mov byte [23], 11110000b

;define
offset equ 0x0000
data equ 0x55aa

;寄存器寻址
mov ax, 0x1000
mov ds, ax

mov al, 0x10
mov ah, 0x10
mov ax, data

;立即寻址
mov ax, [offset] ;0x1000 * 0x10 + 0 = 0x100000
mov [offset], ax
mov byte [offset], 0x10
mov word [offset], 0x10
mov dword [offset], 0x10

;间接寻址 bx bp si di

mov ax, [bx]; [ ds * 16 + bx ]
mov ax, [bp]; [ ss * 16 + bp ]
mov ax, [si]; [ ds * 16 + si ]
mov ax, [di]; [ ds * 16 + di ]

mov ax, [ bx + si + 0x1000 ];





halt:
     jmp halt

times 510 - ($ - $$) db 0
db 0x55, 0xaa
