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
    s resd 100
    a resd 1
    read_format db "%d",0
    k dw 5
    print_format db "%d ",0
    print_format2 db "%x ",0
    
    

; our code starts here
segment code use32 class=code
    start:
    mov edi,s
        citire:
        push dword a
        push dword read_format
        call [scanf]
        add esp,4*2
        
        cmp dword[a],0
        je gata_citirea
        mov edx,0
        mov eax,[a]
        mov bx,10
        mov cx,0
        suma_cifre:
        div bx
        add cx,dx
        mov edx,0
        movzx eax,ax
        cmp eax,0
        je verifica
        jne suma_cifre
        verifica:
        cmp cx,word[k]
        je adauga_sir
        jne citire
        
        adauga_sir:
        
        
        mov eax,[a]
        mov dword[edi],eax
        add edi,4
        jmp citire
        
        gata_citirea:
        mov edi,s
        
        afiseaza1:
        
        push dword [edi]
        push dword print_format
        call [printf]
        add esp,4*2
        add edi,4
        cmp dword[edi],0
        je gata_afisare1
        jmp afiseaza1
        gata_afisare1:
        mov edi,s
        afiseaza2:
        
        push dword [edi]
        push dword print_format2
        call [printf]
        add esp,4*2
        add edi,4
        cmp dword[edi],0
        je gata_afisare2
        jmp afiseaza2
        gata_afisare2:
        
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
