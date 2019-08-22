%include "io.inc"

section .data ; para declarar etiquetas
    var1 DD 21h
    var2 DD 21h
section .text
    
    
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    GET_HEX 4, var1
    GET_HEX 4, var2
    mov eax, [var1]
    sub eax, [var2]
    PRINT_HEX 4, eax 
    xor eax, eax
    ret