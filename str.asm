%include "io.inc"

section .data ; para declarar etiquetas
    str1 DW "HELLO WORLD"

section .text
    
    
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    PRINT_STRING str1
    xor eax, eax
    ret