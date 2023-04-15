bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,gets,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import gets msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s resb 100
    litere_mici resb 100
    litere_mari resb 100
    format_print db "%s %s",0

; our code starts here
segment code use32 class=code
    start:
        push dword s
        call [gets]
        
        
        
        
        mov esi,s
       
        mov eax,litere_mici
        mov ebx,litere_mari
        repeta:
        
        cmp byte[esi],0
        je gata
        
        cmp byte[esi],'A'
        jae continua
        jb  urmatorul
        
        continua :
        cmp byte[esi],'Z'
        jbe litera_mare
        ja verifica_litera_mica
        
        verifica_litera_mica:
        cmp byte[esi],'z'
        ja urmatorul
        cmp byte[esi],'a'
        jb urmatorul
        mov cl,byte[esi]
        mov byte[eax],cl
        inc eax
        jmp urmatorul
        
        litera_mare:
        mov cl,byte[esi]
        mov byte[ebx],cl
        inc ebx
        
        urmatorul:
        inc esi
        jmp repeta
        gata:
        
        push  dword litere_mari
        push  dword litere_mici
        push format_print
        call [printf]
        add esp,4*3
        
        
        
        
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
