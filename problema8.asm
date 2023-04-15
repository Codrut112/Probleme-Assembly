bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,fopen,gets,fprintf,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import gets msvcrt.dll
import fprintf msvcrt.dll
import printf msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    
    print_format db "%c",0
    mod_acces db "w",0
    nume_fisier db "string.txt",0
    descriptor resd 1
    caracter resd 1
    s resb 100

; our code starts here
segment code use32 class=code
    start:
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp,4*2
        cmp eax,0
        je final
        mov [descriptor],eax
        
        push dword s
        call [gets]
        add esp,4
        
        mov esi,s
        
        repeta:
        
        cmp byte[esi],0
        je gata
        
        cmp byte[esi],'A'
        jb urmatorul
        
        cmp byte[esi],'Z'
        ja urmatorul
        mov al,byte[esi]
        mov byte[caracter],al
        
        push dword [caracter]
        push dword print_format
        PUSH dword[descriptor]
        call [fprintf]
        add esp,4*3
        urmatorul:
        inc esi
        jmp repeta
        gata:
        dec esi
        
        
        
        
        repeta_2:
        cmp byte[esi],'a'
        jb urmatorul2
        
        cmp byte[esi],'z'
        ja urmatorul2
        mov al,byte[esi]
        mov byte[caracter],al
        push dword [caracter]
        push dword print_format
        push dword [descriptor]
        
        call [fprintf]
        add esp,4*3
        
        
        urmatorul2:
        cmp esi,s
        je gata2
        dec esi
        
        jmp repeta_2
        gata2:
        final:
        
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
