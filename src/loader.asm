;makefile当中将loader.bin写入master.img的第二扇区连续4* 512B的位置
; mov edi, 0x1000  ;内存偏移CS:edi
; mov ecx, 2       ;扇区起始位置 
; mov bl, 4        ;读取数数
; call read_disk
;boot.asm中读硬盘将loader.bin读到内存0X1000的位置

[org 0x1000]

xchg bx, bx
mov ax, 0xb800
mov es, ax
mov byte [es:0], "L"

xchg bx, bx
jmp $