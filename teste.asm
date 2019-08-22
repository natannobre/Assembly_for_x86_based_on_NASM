%include "io.inc"

section .bss 
array RESD 25
aux RESD 25

section .text
global CMAIN
CMAIN:
    mov ebp, esp
    GET_UDEC 4, [array+(24*4)]
    mov edx, [array+(24*4)]
    mov [aux+(24*4)], edx
    mov ecx, [array+(24*4)]
    dec ecx
    jz fat0_1
    cmp ecx, -1
    jz fat0_1
    mov edi, 24*4
    mov eax, 0
    
operacao:   
mov edx, ecx 
l1:; soma por partes
    mov eax, 0
    cmp ecx, 1
    je continua1
    push ecx 
    mov ecx, 25
    l2:; soma todas as posições do array
        mov ebx, [aux+edi]
        add [array+edi], ebx
        jnc sem_carry
        jc com_carry
        continua:
        sub edi, 4
    loop l2
    mov eax, 0
    mov edi, 24*4
    pop ecx
    loop l1
  
  continua1:
    mov ecx, 25
    mov edi, 24*4
    l3:; atualiza as posições
    mov eax, [array+edi]
    mov [aux+edi], eax
    loop l3
    
    dec edx
    mov ecx, edx
    and ecx, ecx
    jnz l1
    
fim:
    mov edi, 0
    mov ecx, 25
    l6:
    PRINT_HEX 4, [array+edi]
    PRINT_CHAR " "
    add edi, 4
    dec ecx
    jnz l6
    
    xor eax, eax
    ret
    
sem_carry:
    add [array+edi], eax
    mov eax, 0
    jc com_carry
    jmp continua
   
com_carry:
    add [array+edi], eax
    mov eax, 1
    jc com_carry
    jmp continua
    
fat0_1:
    mov edi, 23*4
    mov eax, 1
    mov ecx, 25
    mov [array+(24*4)], eax
    mov eax, 0
    l5:
    mov [array+edi], eax
    sub edi, 4
    loop l5
    jmp fim
