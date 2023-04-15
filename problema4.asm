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
    nr_litere dd 0
    format_print db "%d ",0

; our code starts here
segment code use32 class=code
    start:
        
        push dword s
        call [gets]
        add esp,4
        
        mov edi,s
        
        repeta:
        cmp byte[edi],0
        je gata
        
        cmp byte[edi]," "
        je afiseaza_numar
        jne incrementeaza_numar
        
        afiseaza_numar:
        push dword [nr_litere]
        push dword format_print
        call [printf]
        add esp,4*2
        inc edi
        mov dword[nr_litere],0
        jmp repeta
        
        incrementeaza_numar:
        add dword[nr_litere],1
        inc edi
        jmp repeta
        
        gata:
        
        push dword [nr_litere]
        push dword format_print
        call [printf]
        add esp,4*2
        
        
        
    
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
