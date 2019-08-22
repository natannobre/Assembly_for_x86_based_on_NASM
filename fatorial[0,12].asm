%include "io.inc"

section .bss
fat RESD 1

section .text
global CMAIN
CMAIN:
    mov ebp, esp   
    GET_DEC 4, [fat]
    mov eax, [fat]
    mov ebx, [fat]
    mov ecx, [fat]
    dec ecx
    jz fat0_1
    cmp ecx, -1
    jz fat0_1
L1:
    mov edx, ecx
    dec ecx   
    L2:
        add ecx, 0
        jz fim
        add eax, ebx
    loop L2   
    mov ecx, edx
    mov ebx, eax
loop L1
    jmp fim     
    
fat0_1:
    mov eax, 1     
fim:
    PRINT_UDEC 4, eax
    xor eax, eax
    ret