bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,gets,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import gets msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s resb 100
    n db 3
    contor db 0
    cuvant resb 100
    print_format db "%s",0
; our code starts here
segment code use32 class=code
    start:
        
        
        push dword s
        call [gets]
        add esp,4
        mov edi,cuvant
        mov bl,byte[n]
        sub bl,1
        mov esi,s 
        
        cmp byte[n],1
        je repeta_2
        
        repeta:
        
        inc esi
        cmp byte[esi-1],' '
        je numara
        
        jmp repeta
        
       numara:
      
       add byte[contor],1
       mov al,byte[contor]
       cmp al,bl
       je cuvant_formare
       jne repeta
       
       cuvant_formare:
       
       
       repeta_2:
        
       movsb
       cmp byte[esi],0
       je gata
       cmp byte[esi],' '
       je gata
       jne repeta_2
       
       gata:
       
       push dword cuvant
       push dword print_format
       call [printf]
       
        
        
        
        
        
        
        
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
