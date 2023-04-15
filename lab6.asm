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
    s db 1,2,3
    ls equ $-s
    d resb ls

;se da un sir de bytes ,sa se copieze acest sir intr-un alt sir
segment code use32 class=code
    start:
        ; ...
    mov esi,s;
    add esi,ls
    sub esi,1
    mov edi,d
    ;ClD ;pentru pacrcurgere de la stanga la dreapta (de la adresa 0 la ultima adresa a sirului)
    mov ecx,ls 
    repeta:
      ; mov al,byte[s+esi]
      ; mov byte[d+di],al
       ;inc esi
       ;inc edi
       STD
       lodsb    
       ;STOSB    
       ;;MOVSB
       CLD  
       STOSB
       loop repeta 
       ;REP MOVSB
       
        
        ;invers:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
