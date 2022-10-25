[bits 32]


extern exit

section .text
global main
main:
    ; mov eax, cr0   ;Segmentation fault (core dumped)
    ;in al, 0x92      ;Segmentation fault (core dumped)应用程序不能操作IO
    push 0
    call exit

