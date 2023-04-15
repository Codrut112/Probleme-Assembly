bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,scanf,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import scanf msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    n resd 1
    a resd 1
    suma_par dd 0
    suma_impar dd 0
    dif dd 0
    format_citire db "%d",0
    mesaj db "numarul de elemente:",0

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
        
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
