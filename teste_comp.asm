%include "io.inc"

section .data
var1 DD 0xffffffff
var2 DD 0xffffffff

section .bss
teste RESD 2

section .text
global CMAIN
CMAIN:
    mov eax, [var1]
    mov ebx, [var2]
    add eax, ebx
    jc carry
    continua:
    mov [teste+(1*4)], eax
   
    PRINT_HEX 4, [teste+(0*4)]
    PRINT_CHAR " "
    PRINT_HEX 4, [teste+(1*4)] 
    xor eax, eax
    ret
    
    carry:
    push eax
    mov eax, [teste+(0*4)]
    add eax, [teste+(0*4)]
    inc eax
    mov [teste+(0*4)], eax
    pop eax
    jmp continua