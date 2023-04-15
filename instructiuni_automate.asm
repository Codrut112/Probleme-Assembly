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
    d resb ls

; se da un sir de bytes 
;sa se in  sirul d byti impari din sir
segment code use32 class=code
    start:
        ; ...
        mov ecx,ls
        mov esi,s
        mov edi,d
        repeta:
            lodsb
            mov dl,al
            and dl,00000001b
            cmp dl,0
            je par
            JG impar
            impar:
              stosb
              
              jmp myendif
          
              
            myendif:
            par:
        loop repeta
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
