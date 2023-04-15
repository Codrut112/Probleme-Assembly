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
     s db 1,-1,2,3,-4,5
     ls equ $-s
     p resb ls
     n resb ls
     
; oregistrii folositi cu rol de indx: ebp-extended base pointer sau ebx extended base reg
segment code use32 class=code
    start:
        ; ...
     ;mov esi,0
    ; mov edi,0
     ;mov ebp,0
     
     mov esi,s
    mov edi,n
    mov ebp,p
     mov ecx,ls
     ;!!!!! de stabilit directia
     cld
     repeta:
          ; mov al,byte[s+esi]
          ;inc esi
          lodsb
          cmp al,0
          jge pozitiv
          jl negativ
          pozitiv:
          xchg ebp,edi
          stosb
          xchg ebp,edi
         ; mov byte[p+ebp],al
         ; inc ebp
          
          jmp myendif
       negativ:
       ; mov byte[n+edi],al
       ; inc edi
       stosb
       
       myendif:
       loop repeta
       
         
     
     
     
     
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
