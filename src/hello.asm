
mov ax, 3
int 0x10 ;将显示模式设置为文本

; xchg bx, bx ;//bochssrc设置magic_break: enabled=1 bochs会自动在xchg bx, bx指令打断点

; mov ax, 0xb800
; mov ds, ax
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

halt:
     jmp halt

times 510 - ($ - $$) db 0

db 0x55, 0xaa
