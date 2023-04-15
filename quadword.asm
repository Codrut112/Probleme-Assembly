bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ..
    s dq 1122338855667788h,78h,1020304050607080h,0fffh
    ls equ ($-s)/8
    d resb ls

; se da un sir de quadworduri ,sa se formeze sirul bytilor cu val maxima dun fiecare quadword
segment code use32 class=code
    start:
        ; ...
    mov esi,0
    mov edi,0
    mov ecx,ls
    mov bl,0
    repeta_mare:
       mov edx,ecx
       mov ecx,8
       mov bl,-128
       mov al,byte[s+esi+7]
       cmp al,1111111b
       jae cu_semn
       jbe repeta
       cu_semn: jmp repeta_cu_semn
    repeta:
         mov al,byte[s+esi]
         inc esi
         cmp al,bl
         ja  nou_maxim
         jbe   nu
            nu:
              jmp myendif
            nou_maxim:
               mov bl,al
           myendif:
           
    loop repeta
       sari:jmp endyf
       repeta_cu_semn:
         mov al,byte[s+esi]
         inc esi
         cmp al,bl
         jg  nou_maxim_2
         jle   nu_2
            nu_2:
              jmp myendif_2
            nou_maxim_2:
               mov bl,al
           myendif_2:
           
    loop repeta_cu_semn
       endyf:
      mov byte[d+edi],bl
      inc edi
      mov ecx,edx
    loop repeta_mare
         
    

    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
