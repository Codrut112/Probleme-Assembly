bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
     d dw 50;
     a db 5;
     b db 10;
     c db 5;
     aux resw 1;
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;[(10+d)-(a*a-2*b)]/c
     mov ax,[d]
     add ax,10
     mov [d],ax
     mov ax,0
     mov al,[a]
     mov bl,[a]
     mul bl
     mov [aux],ax
     mov al,[b]
     mov bl,2
     mul bl
     sub [aux],ax
     mov ax,aux
     
     sub [d],ax
       
       MOVZX ax, byte[d]
       div byte[c]
            
     
     
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
