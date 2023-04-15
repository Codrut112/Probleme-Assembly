bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    b db 11110000b
    a dw 1111101111111111b

; Sa se inlocuiasca bitii 0-3 ai octetului B cu bitii 8-11 ai cuvantului A.
segment code use32 class=code
    start:
        mov bl,byte[a+1];bl=a15a14a13a12a11a10a9a8
        and bl,00001111b;bl=0000a11a10a9a8
        mov al,[b];al=b
        shr al,4;al=0000b7b6b5b4
        shl al,4;al=b7b6b5b40000
        or al,bl;al=b7b6b5b4a11a10a9a8
        mov [b],al;b=b7b6b5b4a11a10a9a8
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
