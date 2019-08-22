%include "io.inc"

section .data
array dd 5, 4, 3, 2, 1
tam dd 5
x dd 0

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov eax, [x]
    mov ebx, [tam]
    A:
    PRINT_DEC 1, [array+(4*eax)]
    PRINT_CHAR ' '    
    inc eax
    dec ebx
    jnz A
    
    xor eax, eax
    ret