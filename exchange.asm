%include "io.inc"


section .bss
    soma    RESB    1
    a       RESB    1
    b       RESB    1


section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov eax, 2
    mov ebx, 5
    XCHG eax, ebx 
    
    xor eax, eax
    ret