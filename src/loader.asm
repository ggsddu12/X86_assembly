;makefile当中将loader.bin写入master.img的第二扇区连续4* 512B的位置
; mov edi, 0x1000  ;内存偏移CS:edi
; mov ecx, 2       ;扇区起始位置 
; mov bl, 4        ;读取数数
; call read_disk
;boot.asm中读硬盘将loader.bin读到内存0X1000的位置

[org 0x1000]

; xchg bx, bx
; mov ax, 0xb800
; mov es, ax
; mov byte [es:0], "L"
;内存检测
check_memory:
    mov ax, 0
    mov es, ax
    xor ebx, ebx
    mov edx, 0x534d4150
    mov di, ards_buffer
.next:
    mov eax, 0xE820
    mov ecx, 20
    int 0x15

    jc .error

    add di, cx
    inc word [ards_count]
    cmp ebx, 0
    jnz .next

    ; xchg bx, bx
    
    mov cx, [ards_count]
    mov si, 0
.show:
    mov eax, [si+ards_buffer]
    mov ebx, [si+ards_buffer+8]
    mov edx, [si+ards_buffer+16]
    add si, 20
    xchg bx, bx
    loop .show
.error:

jmp $


ards_count:
    dw 0
ards_buffer:
    
