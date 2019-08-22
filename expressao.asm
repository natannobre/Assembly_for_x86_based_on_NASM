%include "io.inc"

section .data

Xval dd 15
Yval dd 3
Zval dd 5

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    mov eax, [Zval]
    sub eax, [Yval]
    mov ebx, [Xval]
    sub ebx, eax
    PRINT_DEC 1, ebx    
    
    
    
    xor eax, eax
    ret