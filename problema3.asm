bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,scanf, gets,printf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import gets msvcrt.dll
import printf msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    
    sursa resb 100
    destinatie resb 100
    inv resb 100
    format_print db "%s ",0
    

; our code starts here
segment code use32 class=code
    start:
    
    
    push dword sursa
    
    call [gets]
    add esp,4*2
    
    mov esi,sursa
    mov edi,destinatie
    
    repeta:
    
    cmp byte[esi],0
    je final_repeta
    
    cmp byte[esi],' '
    jne stocheaza_caracter
    je inverseaza_cuvant
    
    stocheaza_caracter:
    movsb 
    jmp repeta
    
    inverseaza_cuvant:
    
    sub edi,1
    mov ebx,inv
    
    repeta_inversare:
    
    cmp edi,destinatie-1
    je gata_inversare
     
    mov al,byte[edi]
    mov byte[ebx],al
    inc ebx
    dec edi
    jmp repeta_inversare    
    
    gata_inversare:
    
    push dword inv
    push dword format_print
    call [printf]
    add esp,4*2
    
    mov edi,destinatie
    add esi,1
    jmp repeta
    
    final_repeta:
    sub edi,1
    mov ebx,inv
    repeta_inversare2:
    
    cmp edi,destinatie-1
    je gata_inversare2
     
    mov al,byte[edi]
    mov byte[ebx],al
    inc ebx
    dec edi
    jmp repeta_inversare2 
    
    gata_inversare2:
    push dword inv
    push dword format_print
    call [printf]
    add esp,4*2
    
    
    
   
    
    
    
    
    
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
