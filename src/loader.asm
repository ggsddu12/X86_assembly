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
    mov ax, data_selector   ;用data_selector初始化其它段寄存器（除CS）
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov fs, ax
    mov gs, ax
    
    xchg bx, bx 

    call setup_page
    mov byte[0xc00b8000],'P'
    ; mov esp, 10000
    ; mov ax, test_selector
    ; mov gs, ax
    ; mov word [gs:0], 0x55aa
    ; ; mov byte [0xb8000], 'P'
    ; xchg bx, bx

    ; ; mov byte[0x200000], 'P'
    ; ; xchg bx, bx
    xchg bx, bx 
    jmp $

PDE equ 0x2000 ;页目录表起始地址，页目录共占4KB 2^12 = 10000 0000 0000 =0x1000，后面紧挨着页表
PTE equ 0x3000 ;页表起始地址
ATTR equ 0b11


setup_page:
    mov eax, PDE
    call .clear_page
    mov eax, PTE
    call .clear_page
    ;前1M映射
    ;前1M映射到0xC0000000 -> 0xC0100000
    mov eax, PTE
    or eax, ATTR
    mov [PDE], eax        ;0b_(00000_00000)_(00000_00011)_(00000_00000_11)
                               ;index PDE    ;index PTE =3   ;页内偏移  = 3
    mov [PDE+ 0x300* 4], eax ;0b_11000_00000_00000_00000_00000_00000_00 = 0xC0000000
                          ;index PDE=0x11_0000_0000 = 0x300

    mov eax, PDE
    or eax, ATTR
    ;页目录共有1024个，2^10=100 0000 0000 = 0x400 即编号为 0 - 0x3ff
    mov [PDE + 0x3ff * 4], eax;最后一个页目录项指向页目录开头
           
    ;将页表项结构装入页表
    mov ebx, PTE            ;页表
    mov ecx, (0x100000 / 0x1000);内存前1M共256个页
    mov esi, 0              ;页索引
.next_page:
    mov eax, esi            
    shl eax, 12             ;高20位放页基址，低12位清0
    or eax, ATTR            ;低12位置属性
    mov [ebx+esi*4], eax
    inc esi
    loop .next_page
    
    mov eax, PDE
    mov cr3, eax

    mov eax, cr0
    or eax, 0b1000_0000_0000_0000_0000_0000_0000_0000
    mov cr0, eax
    ret


.clear_page:
    ;清空eax开始的4K内存，全部置0 
    mov ecx, 0x1000  ;4K
    mov esi, 0
.set:
    mov byte[eax+esi],0
    inc esi
    loop.set
    ret 


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
    
