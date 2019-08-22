%include "io.inc"

section .data ; para declarar etiquetas
    var1 DD 21h

section .text
    
    
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov eax, [var1]; o colchete pega o conteúdo da etiqueta
    sub eax, 10h
    mov [var1], eax
    PRINT_HEX 4, [var1] 
    xor eax, eax
    ret