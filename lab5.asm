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
    s db -1,-2,10,11,4,5;r=1,-2
    ls equ $-s
    r resb ls

; se da un sir de bytes 
;sa se stearga un sir valorile negative
segment code use32 class=code
    start:
        ; ...
        mov ecx,ls
        mov esi,0
        mov edi,0
        repeta:
            mov al,byte[s+esi]
            cmp al,0
            JL negativ
            JGE pozitiv
            negativ:
              mov byte[r+edi],al
              add edi,1
              jmp myendif
            pozitiv:
              add esi,1
            myendif:
        loop repeta
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
