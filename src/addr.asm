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

mov ax, [bx]; ds * 16 + [bx]
