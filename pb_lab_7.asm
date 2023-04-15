bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
   s dw  1,5,10,11,12
   ls equ ($-s)/2
   d resb ls
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi,0
        mov edi,0
        mov ecx,ls
        repeta:
          mov bl,0
          mov edx,ecx
          mov ax,word[s+esi]
          mov ecx,16
         calculeaza:
          shr ax,1;cf=1
          adc bl,0
         loop calculeaza
         mov byte[d+edi],bl
         inc edi
         add esi,2
         mov ecx,edx
         loop repeta
         
                   
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
