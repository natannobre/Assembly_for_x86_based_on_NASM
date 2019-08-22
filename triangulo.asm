%include "io.inc"

section .data
equi DB "equilátero",0
iso DB "isóceles",0
esca DB "escaleno",0
naoe DB "não é triangulo",0

section .bss
lado_1 RESD 1
lado_2 RESD 1
lado_3 RESD 1

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    GET_UDEC 4, [lado_1]
    mov eax, [lado_1]
    cmp eax, 0
    je nops
    GET_UDEC 4, [lado_2]
    mov eax, [lado_2]
    cmp eax, 0
    je nops
    GET_UDEC 4, [lado_3]
    mov eax, [lado_3]
    cmp eax, 0
    je nops
    
    call soma_sub
    cmp eax, 1
    jz FIM
    call qual
    add eax, 0
    cmp eax, 2
    je equilatero
    add eax, 0
    cmp eax, 3
    je isoceles
    add eax, 0
    cmp eax, 4
    je escaleno
         
FIM:    
    PRINT_STRING [edx]            
    xor eax, eax
    ret
    
soma_sub:
    mov eax, [lado_2]
    add eax, [lado_3]
    cmp eax, [lado_1]
    jb n_triangulo
    mov eax, [lado_2]
    add eax, [lado_1]
    cmp eax, [lado_3]
    jb n_triangulo
    mov eax, [lado_3]
    add eax, [lado_1]
    cmp eax, [lado_2]
    jb n_triangulo
end:
    ret
   
n_triangulo:
    mov edx, naoe
    mov eax, 1
    jmp end
    
qual:
    .equi:
        mov eax, [lado_1]
        cmp eax, [lado_2]
        jne .pula
        cmp eax, [lado_3]
        jne .pula1
        mov eax, 2
        ret
        .pula:
            mov eax, [lado_1]
            cmp eax, [lado_3]
            jne .pula0.1
            mov eax, 3
            ret
            .pula0.1:
                mov eax, [lado_2]
                cmp eax, [lado_3]
                jne .pula0.2
                mov eax, 3
                ret
                .pula0.2:
                    mov eax, 4
                    ret
        .pula1:
            mov eax, 3
            ret
equilatero:
    mov edx, equi
    jmp FIM  
    
isoceles:
    mov edx, iso
    jmp FIM
    
escaleno:
    mov edx, esca
    jmp FIM 
nops:
    mov edx, naoe
    jmp FIM           