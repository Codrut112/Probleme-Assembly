bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; 
     ;(a*b)-(c*d)
       b db 64
      c dw 2847
       a db 156
        d dd -823548
       
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov al,[a]
        mul byte[b]
       ; mov bx,ax
       ; mov dx,0
       ; mov ax,[c]
       ; push dx
       ; push ax  
        pop eax;eax= dx:a//
        mov eax,0
        mov ax,[c]  
        mul dword [d]
        ;bx=a*b
         ;edx:eax=c*d   
        mov ecx,0
        mov cx,bx
         add ecx,eax
         adc edx,0
         ;edx:ecx=(a*b)+(c*d)         
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
