%include "io.inc"

section .data

    CaseTable DD 300
    DD Process_50
    EntrySize EQU ($ - CaseTable) 
    DD 500        
    DD Process_40           
    DD 700
    DD Process_30
    DD 800
    DD Process_20
    DD 1000
    DD Process_10
    NumberOfEntries EQU ($ - CaseTable) / EntrySize
    DD Process_acima
 
section .text
global CMAIN
CMAIN:
    mov ebp, esp
    GET_UDEC 4, eax
    mov ebx, CaseTable            
    mov ecx, NumberOfEntries      
       
L1: cmp eax,[ebx]                  
    jnbe L2                        
    call [ebx + 4]               
    PRINT_UDEC 4, edx          
    PRINT_CHAR '%'
    NEWLINE
    jmp L3   
                         
L2: add ebx,EntrySize             
    dec ecx
    jnz L1
    call Process_acima
    PRINT_DEC 4, edx
    PRINT_CHAR '%'
    jmp L3   
                         
L3:
    xor eax, eax
    ret
    
Process_50:
mov edx, 50
ret
Process_40:
mov edx, 40
ret
Process_30:
mov edx, 30
ret
Process_20:
mov edx, 20
ret
Process_10:
mov edx, 10
ret
Process_acima:
mov edx, 5
ret