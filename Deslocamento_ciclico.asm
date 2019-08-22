%include "io.inc"
section .data
    ArrayDW DD 1,2,3, 4, 5, 7, 8, 10, 11, 12309, 1273, 231273
    sizeArray DD ($-ArrayDW)/4
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov ecx, [sizeArray]
    push ecx
    mov eax, [ArrayDW + (ecx-1)*4]
    mov ebx, 0
    mov edx, 0
l1:
    mov edx, [ArrayDW + ebx*4]
    mov [ArrayDW + ebx*4], eax
    inc ebx
    mov eax, [ArrayDW + ebx*4]
    mov [ArrayDW + ebx*4], edx
    inc ebx
    sub ecx,2
    jns l1
    pop ecx
    mov ebx, 0
l2:
    mov eax, [ArrayDW + ebx*4]
    PRINT_DEC 4, eax
    PRINT_STRING " "
    inc ebx
    dec ecx
    jnz l2
    xor eax, eax
    ret