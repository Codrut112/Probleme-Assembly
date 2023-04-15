bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    
  import printf msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    sir dd 1234A678h,12785634h,1a4d3c2bh
    len equ ($-sir)/4
    sir2 resw len
    print_format db 'numarul de biti de 1 este %d',0
    suma db 0


segment code use32 class=code
    start:
    mov esi,sir
    mov edi,sir2
    mov ecx,len
    repeta:
    add esi,1;incrementam edi acum suntem la adresa unde octetului superior din cuvantul inferior din dw
    lodsb;il punem in al
    stosb;il stocam in sir
    push ecx;salvam ecx
    mov ecx,8;punem in ecx 8 
    suma1:;suma bitilor
    shl al,1
    adc byte[suma],0
    loop suma1
    mov ecx,8
    add esi,1;acum in edi avem adresa octetului superior din cuvantul superior
    lodsb;il incarcam in al
    stosb;il punem in sir
    suma2:
    shl al,1
    adc byte[suma],0
    loop suma2
    pop ecx
    loop repeta
    
    movzx eax,byte[suma]
    push eax
    push dword print_format
    call [printf]
    add esp,4*2
    
    
    
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
