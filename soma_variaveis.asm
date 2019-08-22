%include "io.inc"


section .bss
    soma    RESB    1
    a       RESB    1
    b       RESB    1


section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    GET_DEC 1, a
    GET_DEC 1, b
    mov al, [a]
    add al, [b]
    mov [soma], al
    PRINT_UDEC 1, [soma] 
    
    xor eax, eax
    ret