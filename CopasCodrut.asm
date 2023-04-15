bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,scanf,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll                       ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a resd 1
    read_format db "%x",0
    k db 55h
    s resd 100
    contor db 0
    print_format db "%x ",0
    
    

; our code starts here
segment code use32 class=code
    start:
    
    mov edi,s
    repeta:
    add byte[contor],1
    push dword a
    push dword read_format
    call [scanf]
    add esp,4*2
    
    mov eax,[a]
    cmp eax,-1
    je gata_citirea
    
    
    mov al,[k]
    mov byte[a+3],al
    mov eax,[a]
    mov dword[edi],eax
    add edi,4
    jmp repeta
    
    gata_citirea:
    sub byte[contor],1
    mov edi,s
    
    afiseaza:
    
    
    sub byte[contor],1
    push dword [edi]
    push dword print_format
    call [printf]
    add esp,4*2
    mov al,byte[contor]
    cmp al,0
    je gata_afisarea
    add edi,4
    je gata_afisarea
    jmp afiseaza
    gata_afisarea:
    
    
    
    
    

    
    
    
    
    
    
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
