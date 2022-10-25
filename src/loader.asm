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
    jmp prepare_protect_mode
; .show:
;     mov eax, [si+ards_buffer]
;     mov ebx, [si+ards_buffer+8]
;     mov edx, [si+ards_buffer+16]
;     add si, 20
;     xchg bx, bx
;     loop .show
.error:
    mov ax, 0xb800
    mov es, ax
    mov byte[es:0],"E"
    jmp $

prepare_protect_mode:
    cli ;关中断
    in al, 0x92
    or al, 0b10
    out 0x92, al   ;打开A20线
    lgdt [gdt_ptr] ;加载GDT，将GDT的位置写入GDTR
    mov eax , cr0  ;cr0最低位置1
    or eax, 1
    mov cr0, eax
    jmp dword code_selector:protect_enable
    ud2;出错


[bits 32]
protect_enable:
    xchg bx, bx
    mov ax, data_selector   ;用data_selector初始化其它段寄存器（除CS）
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov fs, ax
    mov gs, ax

    mov esp, 10000
    mov ax, test_selector
    mov gs, ax
    mov word [gs:0], 0x55aa
    ; mov byte [0xb8000], 'P'
    xchg bx, bx

    ; mov byte[0x200000], 'P'
    ; xchg bx, bx

    jmp $

base equ 0        ;32位
limit equ 0xfffff ;20位

code_selector equ (1<<3)          ; index=1(13bit),低三位TI/RPL置0
data_selector equ (2<<3)          ; index=2
test_selector equ (3<<3)
gdt_ptr: ;GDTR
    dw ( gdt_end - gdt_base - 1 ) ; limit = size - 1，GDT长度
    dd gdt_base                   ; base  GDT地址

gdt_base: ;GDT
    dd 0,0                       ;空 代码段 数据段

gdt_code:                        ;代码段初始化
    dw limit & 0xffff;           ;limit 0-15
    dw base & 0xffff             ; base 0-15
    db (base>>16)&0xff           ; base 16-23  
    db 0b1110 | 0b1001_0000
    db 0b1100_0000 | (limit >> 16)
    db (base>>24) & 0xff


gdt_data:                        ;数据段初始化
    dw limit & 0xffff;
    dw base & 0xffff
    db (base>>16)&0xff
    db 0b0010 | 0b1001_0000
    db 0b1100_0000 | (limit >> 16)
    db (base>>24) & 0xff
gdt_test:
    dw 0xfff
    dw 0x0
    db 0x1
    db 0x92
    db 0x40
    db 0x0                       ;base 0x10000
gdt_end:

ards_count:
    dw 0
ards_buffer:
    
