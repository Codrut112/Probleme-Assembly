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
    s dw 1111111111111111b,111111100000111b,0,0000011100000111
    ls equ $-s
    r resb ls

; se da un sir de word 
;sa se salveze intr-un doar biti care au ultima cifra 7
segment code use32 class=code
    start:
        ; ...
        mov ecx,ls
        mov esi,0
        mov edi,0
        repeta:
            mov al,byte[s+esi]
            and al,0111b
            cmp al,7
            JE seterminacu7
            JnE nuseterminacu7
            seterminacu7:
            mov al,byte[s+esi]
              mov byte[r+edi],al
              add edi,1
              jmp myendif
            nuseterminacu7:
              
            myendif:
            add esi,1
        loop repeta
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
