bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions


segment data use32 class=data
s dq 1110111b,100000000h,0002e7fch,5,11101111b

len equ ($-s)/8
rez resd len   
print_format db '%x ',0
print_formatul db '%d',0
spatiu db '  ',0
contor dd 0
ok db 0
; our code starts here
segment code use32 class=code
    start:
    mov edi,s;punem adresa sirului in edi
    mov ecx,len;punem lungimea sirului in ecx
    mov esi,rez;punem adresa sirului rezultat in esi
    repeta:
   
    
    
    push ecx;salvam ecx
    mov eax,[edi];punem eax dw inferior
    mov ebx,eax;salvam eax
    mov ecx,32
    mov dl,0
    verifica:;verifica daca sunt 3 de 1 consecutivi
    
    cmp ecx,0
    jle gata_verificare1
    
     dec ecx
     shl eax,1
     jnc verifica
     
     dec ecx
     shl eax,1
     jnc verifica
     
     
     
     dec ecx
     shl eax,1
     jnc verifica
     
     add dl,1
     jmp verifica
     
     
    gata_verificare1:
    cmp byte[ok],1
    je gata_verificare2
    mov byte[ok],1
    
    mov eax,[edi+4];punem eax dw superio
    mov ecx,32
    jmp verifica
    gata_verificare2:
    pop ecx
    add edi,4
    
    cmp dl,2;daca sunt 2 secvente de 111 atunci adaugam in sir
    jae adauga_sir
    loop repeta
    
    
    
    
    
    
    cmp dword[contor],0
    ja afisare
    jz gata
    
    adauga_sir:
  
    mov [esi],ebx
    add esi,4
    add dword[contor],1;incrementam contorul
    loop repeta
    
    
    afisare:
    mov ebx,0
    
    afiseaza:
    push dword[rez+ebx]
    push print_format
    call [printf]
    add esp,4*2    
    inc ebx
    cmp ebx,dword[contor]
    je afisare2
    jmp afiseaza
    
    
    afisare2:
    mov ebx,0
    afiseaza2:
    push spatiu;afisam spatiu intre 
    call [printf]
    add esp,4*1  
    mov cl,31
    mov byte[ok],0
    afisare_pe_biti:
    mov edx,dword[rez+ebx];afisam bit cu bit
    shr edx,cl 
    and edx,1
    cmp edx,0
    ja seteaza_ok;setam un ok la prima inatlnire a unui bit nenul
    intoarece:
    push ecx
    cmp byte[ok],1
    jne nu_afisa
    push edx
    push print_formatul;afisare
    call [printf]
    add esp,4*2  
    pop ecx
    nu_afisa  :
    dec cl
    cmp cl,-1
    jne afisare_pe_biti
    inc ebx
    cmp ebx,dword[contor]
    je gata
    jmp afiseaza2
    seteaza_ok:
    mov byte[ok],1
    jmp intoarece
    gata:
    
    
    
    
    
    
    
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
