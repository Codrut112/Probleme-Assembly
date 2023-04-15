bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,fscanf,fopen,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fscanf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fopen msvcrt.dll
import printf msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    nume_fisier db "numere.txt",0
    mod_acces db "r",0
    descriptor resd 1
    format_citire db "%c",0
    format_print db "%s %s",0
    contor dd 0
    a dd 0
    n resb 100
    p resb 100
    numar resb 100

; our code starts here
segment code use32 class=code
    start:
    push mod_acces
    push nume_fisier
    call [fopen]
    add esp,4*2
    
    cmp eax,0
    je final
    
    mov [descriptor],eax
    mov edi,0
    mov esi,p
    mov ecx,n
    
    repeta:
   
    push dword a
    push dword format_citire
    push dword [descriptor]
    call [fscanf]
    add esp,4*3
    
    cmp eax,-1
    je final
    
    cmp byte[a],' '
    je stocare_numar
    jne procesare 
    
    procesare:
    mov bl,[a]
    mov byte[numar+edi],bl 
    inc edi
    jmp repeta
    
    stocare_numar:
    mov bl,[a]
    mov byte[numar+edi],bl
    mov bl,byte[numar+edi-1]
    sub bl,'0'
    and bl,1b
    cmp bl,1b
    je impar
    jne par
    par:
    mov [contor],edi
    add esi,edi
    pune_elm1:
    mov bl,byte[numar+edi]
    mov byte[esi],bl
    dec edi
    dec esi
    cmp edi,-1
    je actualizeaza1
    jmp pune_elm1
    actualizeaza1:
    mov edi,0
    add esi,[contor]
    
    
    
   impar:
   
   mov [contor],edi
   add ecx,edi
   pune_elm2:
  
    add ecx,edi
    mov bl,byte[numar+edi]
  
    mov byte[ecx],bl
      push numar
   call [printf]
   add esp,4
    dec edi
    
    dec ecx
    
    cmp edi,-1
     
    je acualizeaza2
    jmp pune_elm2
    acualizeaza2:
    mov edi,0
    add ecx,[contor]
   
     jmp repeta
    
    push dword p
    push dword n 
    push format_print
    call [printf]
    add esp,4*3
    
    
    final:
    
    
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
