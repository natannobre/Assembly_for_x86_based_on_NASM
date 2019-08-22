%include "io.inc"

section .data
    CaseTable DB 'D'        ; lookup value
    DD Process_A_D           ; address of procedure
    EntrySize EQU ($ - CaseTable)
    DB 'H'
    DD Process_E_H
    DB 'L'
    DD Process_I_L
    DB 'P'
    DD Process_M_P
    DB 'T'
    DD Process_Q_T
    DB 'Z'
    DD Process_U_Z
    NumberOfEntries EQU ($ - CaseTable) / EntrySize
    DD Process_default
    msgA DB "Intervalo_A_B_C_D",0
    msgB DB "Intervalo_E_F_G_H",0
    msgC DB "Intervalo_I_J_K_L",0
    msgD DB "Intervalo_M_N_O_P",0
    msgQ DB "Intervalo_Q_R_S_T",0
    msgU DB "Intervalo_U_V_X_Y_Z",0
    msgdef DB "Deu Ruim",0
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    GET_CHAR al
    mov ebx, CaseTable            ; point EBX to the table
    mov ecx, NumberOfEntries      ; loop counter
    cmp al, 'A'
    jb L0    
L1: cmp al,[ebx]                  ; match found?
    jnbe L2                        ; no: continue
    call [ebx + 1]                ; yes: call the procedure
    PRINT_STRING [EDX]            ; display message
    NEWLINE
    jmp L3                        ; and exit the loop
L2: add ebx,5;EntrySize             ; point to next entry
    dec ecx
    JNZ L1                        ; repeat until ECX = 0
L0:
    call Process_default
    PRINT_STRING [EDX]
L3:
    xor eax, eax
    ret
    
Process_A_D:
mov edx, msgA
ret
Process_E_H:
mov edx, msgB
ret
Process_I_L:
mov edx, msgC
ret
Process_M_P:
mov edx, msgD
ret
Process_Q_T:
mov edx, msgQ
ret
Process_U_Z:
mov edx, msgU
ret
Process_default:
mov edx, msgdef
ret