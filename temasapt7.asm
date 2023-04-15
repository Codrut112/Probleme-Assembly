bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; Se dau doua siruri de caractere S1 si S2. Sa se construiasca sirul D prin concatenarea elementelor de pe pozitiile multiplu de 3 din sirul S1 cu elementele sirului S2 in ordine inversa.
segment data use32 class=data
    s1 db '+', '4', '2', 'a', '8', '4','X','5'
    ls1 equ $-s1
    s2 db 'a','4','5'
    ls2 equ $-s2
    d resb ls1/3+1+ls2

; our code starts here
segment code use32 class=code
    start:
      
    mov esi,0; mov esi,s1
    mov edi,0;mov edi,d
    mov ecx,ls1
    mov edx,ls1
    ;cld
    repeta: 
        mov bl,byte[s1+esi];LODSB
        mov byte[d+edi],bl;stosb
              add esi,3;add esi,2
               ; mov eax,esi
            ; sub eax,s1
            ; cmp eax,ecx
              inc edi;
            cmp esi,edx;cmp eax,edx
            ja afara
            jle ok
            afara:
            jmp myendif
            ok:
            
          loop repeta
          myendif:
    mov esi,0;mov esi,s2+l2-1
    
    mov ecx,ls2
    ;std
    executa:
     mov bl,byte[s2+ecx-1];
     mov byte[d+edi],bl;
     inc esi;
     inc edi;
     ; std
     ; lodsb
     ; cld
     ; stosb
     loop executa
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
