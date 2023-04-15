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
    a db 12
    b dw 3
    c dw 2
    d dd 9
    aux resd 1

; our code starts here
segment code use32 class=code
    start:
        ; a-7/b+c*(-2)+d
        mov ax,7
        mov dx,0;dx:ax=-7
        idiv word[b];ax=-7/b
        mov bx,ax;bx=-7/b
        mov ax,-2
        imul word[c];dx:ax=c*(-2)
        movsx cx,byte[a]
        sub cx,bx
        mov word[aux+0],ax
        mov word[aux+2],dx
        mov ax,cx
        cwd
        add ax,word[aux+0]
        adc dx,word[aux+2]
        add ax,word[d+0]
        adc dx,word[d+2]
        
        
        
        
        
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
