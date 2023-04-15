bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,scanf,printf,fopen,fprintf,fclose               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import scanf msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    n resd 1
    a resd 1
    suma_par dd 0
    suma_impar dd 0
    dif dd 0
    format_citire db "%d",0
    mesaj db "numarul de elemente:",0
    nume_fisier db "output.txt",0
    mod_acces db 'w',0
    format_print db "%d %d %d",0
    descriptor dd 0

; our code starts here
segment code use32 class=code
    start:
        push dword mesaj
        call [printf]
        add esp,4
        
        push dword n
        push dword format_citire
        call [scanf]
        add esp,4*2
        
        repeta:
        
        sub dword[n],1
        
        push dword a
        push dword format_citire
        call [scanf]
        add esp,4*2
        
        mov eax,[a]
        
        and eax,1b
        
        cmp eax,1
        je impar
        jne par
        

        par: 
        mov eax,[a]
        add   [suma_par],eax     
        jmp salt
        
        impar:
        mov eax,[a]
        add [suma_impar],eax
        salt:
        cmp dword[n],0
        ja repeta
        
        mov ebx,[suma_par]
        sub ebx,[suma_impar]
        
       push dword mod_acces
        push dword nume_fisier
        call [fopen]
        
        add esp, 4*2   
        mov [descriptor],eax
        
            
        ;afisare mesaj fprintf(suma_pare,linie_noua,suma_impare,linie_noua,ebx,format,descriptor)
        push ebx
        
        
        push dword[suma_par]            ;suma_pare e byte
        
        push dword[suma_impar]                 ;suma_impare e byte
        
        push dword format_print
        
        push dword [descriptor]
        
        call [fprintf]
        add esp, 4*4
        
        push dword[descriptor]
        call [fclose]
       
        final:
        
        
        
        
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
