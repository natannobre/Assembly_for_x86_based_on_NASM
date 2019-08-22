%include "io.inc"

section .data ; para declarar etiquetas
    var1 DD 21h

section .text
    
    
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov eax, [var1]; o colchete pega o conteúdo da etiqueta
    mov eax, 565465AFh
    mov al, 0BBh
    PRINT_HEX 4, eax 
    xor eax, eax
    ret