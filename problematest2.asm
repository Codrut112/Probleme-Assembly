bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,scanf,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    sir1 resd 1000
    sir2 resb 1000
    format_citire db '%d',0
    format db 'n='
    n dd 0
    suma_cifre db 0
    contor dd 0
    
segment code use32 class=code
    start:
    
    push dword format
    call [printf]
    add esp,4;afisam n=
    push dword n
    push dword format_citire
    call [scanf];citim numarul
    add esp,4*2
    mov eax,[n]
    mov dword[contor],eax;salvam numarul de elemente care trb citite
    
    mov edi,sir1
    mov esi,sir2
    
    repeta:
    dec dword[contor]
    push n
    push format_citire;citim un dw
    call [scanf]
    add esp,4*2
    mov eax,[n];cum dimensiunea maxima este 65535 numarul incape pe word
    mov [edi],eax
    add edi,4
    mov bx,10
    mov byte[suma_cifre],0
    aduna_cifra:;facem suma cifrelor pare
    push eax
    pop ax
    pop dx
    div bx
    cmp dx,1
    je nu_adauga
    cmp dx,3
    je nu_adauga
    cmp dx,5
    je nu_adauga
    cmp dx,7
    je nu_adauga
    cmp dx,9
    je nu_adauga
    add byte[suma_cifre],dl
    nu_adauga:
    cmp ax,0
    ja restaurare
    mov al,byte[suma_cifre]
    mov [esi],al
    add esi,1
    cmp dword[contor],0
    jne repeta
    
    jmp gata
    restaurare:
    movzx eax,ax
    jmp aduna_cifra
    gata:
    push dword[suma_cifre]
    push dword format_citire
    call [printf]
    add esp,4*2
    mov al,byte[suma_cifre]
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
