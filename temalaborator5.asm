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
    a dw 200
    b dw -2
    c db 10
    d db 5
    e dd -73
    x dq 33
    aux resd 1
; 1/a+200*b-c/(d+1)+x/a-e; a,b-word; c,d-byte; e-doubleword; x-qword
segment code use32 class=code
    start:
        ; bx=1/a
        mov ax,1;ax=1
        mov dx,0;dx:ax=1
        idiv word[a];ax=1/a
        mov bx,ax;bx=1/a
        ;dx:ax=200*b
        mov ax,200;ax=200
        imul word[b]; dx:ax=200*b
        mov word[aux+0],ax
        mov word[aux+2],dx
        ;aux=200*b

        movsx ax,byte[c];ax=c
        mov dl,1;dl=1
        add dl,[d];dl=d+1
        idiv dl;al=c/(d+1)
     
        movsx ax,al
        sub bx,ax;bx=1/a-c/(d+1)
         mov ax,[a];ax=a
        cwde;eax=a
        mov ecx,eax;ecx=a
        mov eax,dword[x+0]
        mov edx,dword[x+4];edx:eax=x
       idiv ecx;eax=x/a
       sub eax,[e];eax=x/a-e
       add eax,[aux];eax=x/a-e+200*b
       mov ecx,eax;ecx=x/a-e+200*b
       mov ax,bx;ax=1/a-c/(d+1)
       cwde
       add ecx,eax
       mov eax,ecx;eax=1/a+200*b-c/(d+1)+x/a-e
        
        
        
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
