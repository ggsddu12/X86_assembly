[bits 32]

; extern printf
; extern exit

; section .text
; global main
; main:
;     push message
;     call printf
;     add esp, 4

;     push 0
;     call exit

; section .data   
;     message db "hello, world!!!", 10,13, 0 ;10 \n   13 \r 
;     message_end：
section .text
global main
main:

    mov eax, 4  ;write中断
    mov ebx, 1  ;标准输出
    mov ecx, message
    mov edx, message_end - message ;长度
    int 0x80  ;软中断

    mov eax, 1 ; exit
    mov ebx, 0 ; status
    int 0x80
section .data   
    message db "hello, world!!!", 10,13, 0 ;10 \n   13 \r 
    message_end: