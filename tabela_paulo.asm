%include "io.inc"
section .data

tabela DD 300
DD ate_300

tamanho_celula EQU ($ - tabela)

DD 500
DD ate_500

DD 700
DD ate_700

DD 800
DD ate_800

DD 1000
DD ate_1000

DD 0xFFFFFFFF ; maior inteiro possivel
DD acima_1000

quantidade_celular EQU ($ - tabela)/tamanho_celula

msg_300 DB "50%", 0
msg_500 DB "40%", 0
msg_700 DB "30%", 0
msg_800 DB "20%", 0
msg_1000 DB "10%", 0
msg_acima_1000 DB "5%", 0

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov esi, tabela
    GET_UDEC 4, ebx
    
    loop_1:
        cmp ebx, [esi]
        jb sair
        add esi, tamanho_celula
        jae loop_1
        
    sair:
        call [esi+4]
        PRINT_STRING [edx]
        
    xor eax, eax
    ret
;----------------------------------    
ate_300:
;Entradas: nenhuma
;Saidas: o ponteiro para a mensagem equivalente em edx
;----------------------------------
    mov edx,msg_300
    ret
;----------------------------------

;----------------------------------    
ate_500:
;Entradas: nenhuma
;Saidas: o ponteiro para a mensagem equivalente em edx
;----------------------------------
    mov edx,msg_500
    ret
;----------------------------------

;----------------------------------    
ate_700:
;Entradas: nenhuma
;Saidas: o ponteiro para a mensagem equivalente em edx
;----------------------------------
    mov edx,msg_700
    ret
;----------------------------------

;----------------------------------    
ate_800:
;Entradas: nenhuma
;Saidas: o ponteiro para a mensagem equivalente em edx
;----------------------------------
    mov edx,msg_800
    ret
;----------------------------------

;----------------------------------    
ate_1000:
;Entradas: nenhuma
;Saidas: o ponteiro para a mensagem equivalente em edx
;----------------------------------
    mov edx,msg_1000
    ret
;----------------------------------

;----------------------------------    
acima_1000:
;Entradas: nenhuma
;Saidas: o ponteiro para a mensagem equivalente em edx
;----------------------------------
    mov edx,msg_acima_1000
    ret
;----------------------------------