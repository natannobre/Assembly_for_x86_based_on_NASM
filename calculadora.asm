%include "io.inc"

section .bss
op RESB 1

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    GET_UDEC 4, EAX
    GET_CHAR op  
    GET_UDEC 4, EBX
    
;SWITCH CASE:--------------------------------    
    mov DL, BYTE[op]
    sub BYTE[op], '+'
    jz som
    mov BYTE[op], DL
    sub BYTE[op], '-'
    jz subt
    mov BYTE[op], DL
    sub BYTE[op], '*'
    jz multi
    mov BYTE[op], DL
    sub BYTE[op], '/'
    jz divs
;--------------------------------------------
    continua:   
    PRINT_UDEC 4, EAX
    xor eax, eax
    ret
    
    err:
    PRINT_STRING "erro"
    xor eax, eax
    ret
;--------------------------------------------------------
;LABELS:-------------------------------------------------    
som:
    call soma
    jmp continua
subt:
    call subtracao
    jmp continua
multi:
    call multiplicacao
    jmp continua
divs:
    call divisao
    jmp continua
;--------------------------------------------------------

;--------------------------------------------------------
soma:
;RESULT: EAX = EAX+EBX
;RETURN: EAX
;RECIVES: EAX, EBX
;--------------------------------------------------------
    add EAX, EBX
    xor EBX, EBX
    ret
;--------------------------------------------------------
subtracao:
;RESULT: EAX = EAX-EBX
;RETURN: EAX
;RECIVES: EAX, EBX
;--------------------------------------------------------
    sub EAX, EBX
    xor EBX, EBX
    ret
;--------------------------------------------------------
multiplicacao:
;RESULT: EAX = EAX*EBX
;RETURN: EAX
;RECIVES: EAX, EBX
;--------------------------------------------------------
    push ECX
    mov ECX, EBX
    mov EBX, EAX
    mov EAX, 0
    .L1:
        add EAX, EBX
        loop .L1
    pop ECX
    xor EBX, EBX
    ret
;--------------------------------------------------------    
divisao:
;RESULT: EAX = EAX/EBX
;RETURN: EAX
;RECIVES: EAX, EBX
;--------------------------------------------------------
    sub EBX, 0
    jz .erro
    mov EDX, EAX   
    push ECX
    mov ECX, EAX
    xor EAX, EAX
    .L1:
        inc EAX         
        sub EDX, EBX
        jz .zero
        jle .fim
        loop .L1
    .fim:
        pop ECX
        dec EAX
        ret 
    .zero:
        pop ECX
        ret 
    .erro:
        jmp err
                
;--------------------------------------------------------                         
                                
                                    
   