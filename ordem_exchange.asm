%include "io.inc"

section .data
array   DW    1, 2, 3, 4

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov ax, [array]
    XCHG [array+6], ax
    XCHG [array], ax
    mov ax, [array+2]
    XCHG [array+4], ax
    XCHG [array+2], ax
    
    PRINT_DEC 2, [array]
    PRINT_DEC 2, [array+2]
    PRINT_DEC 2, [array+4]
    PRINT_DEC 2, [array+6]
    
    xor eax, eax
    ret