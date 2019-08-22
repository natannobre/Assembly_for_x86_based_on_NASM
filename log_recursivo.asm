%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp
    GET_UDEC 4, eax 
    GET_UDEC 4, ecx 
    mov esi, 0
    mov edi, eax
    mov ebx, ecx
    
    cmp eax, 0
    je erro                 ;tratamento de log 0
    
    call log
    PRINT_STRING "LOG DE "
    PRINT_UDEC 4, edi
    PRINT_STRING " NA BASE "
    PRINT_UDEC 4, ebx
    PRINT_STRING " É "
    PRINT_UDEC 4, esi
FIM:
    xor eax, eax
    ret
    
log:
    enter 4,0
    cmp eax, ecx
    jb fora
    mov DWORD[ebp-4], 1     ;salva a contagem em cada nível da recursão
    mov edx, 0
    div ecx
    call log                ;chamada da recursão
    add esi, DWORD[ebp-4]   ;incrementa o contador
                            ;retorno da recursão
    fora:    
        leave
        ret

erro:
    PRINT_STRING "ERRO"
    jmp FIM