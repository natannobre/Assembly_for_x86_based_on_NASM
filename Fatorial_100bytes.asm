%include "io.inc"
section .bss
    fat_1 RESD 25           ;Reservando um array de 32bits com 25 posies
    fat_2 RESD 25           ;Reservando um array auxiliar de 32bits com 25 posies

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging

;  |----------------------------------------------------------------------------------------------------------------------------|
;  | Codigo feito pelos alunos Jorge Lucas e Natan Nobre para materia de Arquitetura de Computadores 2018.1 para o Prof Wagner  |
;  | O codigo consiste em fazer um fatorial de um numero que a respota seja em at 100bytes                                     |
;  | O codigo recebe um numero natural e mostra o fatorial desse numero em hexadecimal                                          |
;  |----------------------------------------------------------------------------------------------------------------------------|
 
    mov ebp, esp; for correct debugging
    mov eax, 0                          ;|--------------------------------------------------|
    mov esi, 0                          ;|                                                  |
    mov ecx, 24                         ;|Inicializando registradores com valores desejados |
    mov ebx, 0                          ;|--------------------------------------------------|
    GET_UDEC 4, [fat_2 + ecx*4]         ;Recebe o valor do numero que ira ser realizado o fatorial
    mov edx, [fat_2 + ecx*4]            ;Move para um registrador auxiliar que ira contar quantas vezes ira ser repetida nos laos internos e externos
    dec edx                             ;Teste para ver se o valor  0 ou 1
    jz FAT_0_OU_1                       ;Pula para um fatorial padro caso 0 ou 1
    js FAT_0_OU_1                       ;Pula para um fatorial padro caso 0 ou 1
    inc edx                             ;Retorna ao valor normal do numero
    Fat_pt1:                            ;Primeira parte do fatorial mais externo 
    dec edx                             ;Decremento do valor para "multiplicao"
    jz MOSTRAR                          ;Teste para ver se o valor j se encontra em 0 se sim, chama a funo que mostra todas as posies do array 1
    mov ecx, edx                        ;Movendo do resgritador auxiliar para o ecx para no perder o valor
    jmp ZERAR                           ;Pulando para a "funo" que zera o primeiro array
    R_ZERAR:                            ;O "retorno" da "funo" que zera o primeiro array
    Fat_pt2:                            ;Segunda parte do fatorail "multiplicao"
    jmp SOMAR                           ;Chama a "funo" que faz a soma de 2 arrays com numeros "grandes" j tratando o carry e armazena no primeiro array
    R_SOMAR:                            ;O "retorno" da "funo" que faz soma de arrays com numeros "grandes" 
    loop Fat_pt2                        
    jmp MOVER                           ;Chama a "funo" que move tudo que est no array 1 "fat_1" para o array 2 "fat_2"
    R_MOVER:                            ;O "retorno" da "funo" que move o array 1 para o array 2
    jmp Fat_pt1                                                  
    R_MOSTRAR:                          ;O "retorno" da "funo" que mostra na tela o array 1
    xor eax, eax
    ret
;--------------------------------------------------------------------------------------------------------------------------------    
MOSTRAR:
        mov ecx, 25                     
        mov esi, 0
        P_M:
            PRINT_HEX 4, [fat_1 + esi * 4]     ;"Funo" que printa cada parte do array separada de um espao
            PRINT_STRING " "
            inc esi
            dec ecx
            jnz P_M
        jmp R_MOSTRAR
;---------------------------------------------------------------------------------------------------------------------------------    
SOMAR:
        push ecx                               ;|----------------------------------------------------------------------------------|
        push esi                               ;|Salvando os valores de registradores que esto sendo usados para que no haja bug |
        push eax                               ;|----------------------------------------------------------------------------------|
        mov ecx, 24
        
        SOMANDO:
            mov esi, ecx                        ;Move para esi o valor da ultima posio do vetor
            mov eax, [fat_1 + esi*4]            ;Move para eax o valor do array 1 
            add eax, [fat_2 + esi*4]            ;Adiciona o valor do array 2 no eax
            jc VAI_UM                           ;Chama a "funo" que move o valor de ebx(que est sendo usado com auxilar para o carry) para 1 e soma com eax (valor incial do ebx  0)
            add eax, ebx                        ;Caso o numero no tenha estorado soma com o carry(ebx)
            mov ebx, 0                          ;Move carry(ebx) para 0 para no ter uma divergencia de valor
            jc VAI_UM                           ;Checa de deu carry e se sim chama funo para mudar o valor de carry
            mov ebx, 0                          ;Move carry(ebx) para 0 para no ter uma divergencia de valor
            R_VAI_UM:                           ;O "retorno" da "funo" que soma o carry atual e modifica o proximo carry
            mov [fat_1 + esi*4], eax            ;Move o valor da soma para array 1
            dec ecx                             ;Drecementa o ecx e faz tudo ate o array na prosio 0
        jns SOMANDO
        pop eax                                 ;|----------------------------------------------------------------------------------|
        pop esi                                 ;|Voltando os valores de registradores que esto sendo usados para que no haja bug |
        pop ecx                                 ;|----------------------------------------------------------------------------------|
        jmp R_SOMAR                             ;Retorno da "funo"
;---------------------------------------------------------------------------------------------------------------------------------        
        VAI_UM:
            add eax, ebx
            mov ebx, 1                          ;"Funo" que adiciona o carry para o registrador auxiliar(caso tenha) e move o valor do proximo carry para 1 
            jmp R_VAI_UM                        ;Retorno da "funo"
 ;--------------------------------------------------------------------------------------------------------------------------------            
MOVER:
        push ecx                                ;|----------------------------------------------------------------------------------|
        push esi                                ;|Salvando os valores de registradores que esto sendo usados para que no haja bug |
        push eax                                ;|----------------------------------------------------------------------------------|
        mov ecx, 25
        mov esi, 0
        MOVENDO:
            mov eax, [fat_1 + esi*4]            ;"Funo" que move todas as posies do array 1 para as posies semelhantes do array 2
            mov [fat_2 + esi*4], eax
            inc esi
        loop MOVENDO
        pop eax                                 ;|----------------------------------------------------------------------------------|
        pop esi                                 ;|Voltando os valores de registradores que esto sendo usados para que no haja bug |
        pop ecx                                 ;|----------------------------------------------------------------------------------|
        jmp R_MOVER                             ;Retorno da "funo"
;---------------------------------------------------------------------------------------------------------------------------------        
ZERAR:
        push ecx                                ;|----------------------------------------------------------------------------------|
        push esi                                ;|Salvando os valores de registradores que esto sendo usados para que no haja bug |
        push eax                                ;|----------------------------------------------------------------------------------|
        mov ecx, 25
        mov esi, 0
        ZERANDO:
            mov eax, 0                          ;"Funo" que move todas as posio do array 1 para o valor 0
            mov [fat_1 + esi*4], eax
            inc esi
        loop ZERANDO
        pop eax                                 ;|----------------------------------------------------------------------------------|
        pop esi                                 ;|Voltando os valores de registradores que esto sendo usados para que no haja bug |
        pop ecx                                 ;|----------------------------------------------------------------------------------|  
        jmp R_ZERAR                             ;Retorno da "funo"
;---------------------------------------------------------------------------------------------------------------------------------       
FAT_0_OU_1:
        mov edx, 1
        mov [fat_1 + 24*4], edx                 ;"Funo" no caso do numero que  desejado o fatorial seja 0 ou 1
        jmp MOSTRAR                             ;Chama a "funo" que mostra na tela o array 1
;---------------------------------------------------------------------------------------------------------------------------------       