bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf,gets,fopen               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import gets msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
import 
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    nume_output db "output.txt",0
    mod_acces1 db "r",0
    mod_acces2 db "w",0
    format_citire db "%s",0
    nume_fisier resd 1
    

; our code starts here
segment code use32 class=code
    start:
        
        
       
        push dword nume_fisier
        call [gets]

        ;fopen(nume_fisier,mod_acces)
        push dword nume_fisier
        push dword format_citire
        call [printf]
        
        push dword mod_acces1
        push dword nume_fisier
        call[fopen]
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
