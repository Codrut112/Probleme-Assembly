bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; Se da un sir de dublucuvinte. Sa se obtina sirul format din octetii inferiori ai cuvintelor superioare din elementele sirului de dublucuvinte care sunt palindrom in scrierea in baza 10.
;s DD 12345678h, 1A2C3C4Dh, 98FCDC76h
;d DB 2Ch, FCh.
segment data use32 class=data
    s dd 12345678h, 1A2C3C4Dh, 98FCDC76h
    ls equ ($-s)/4
    d times ls db 0
    

; our code starts here
segment code use32 class=code
    start:
    mov esi,s
    mov edi,d
    mov ecx,ls;ecx=ls
    jecxz final
    repeta:
      add esi,2;esi=esi+2
      lodsb;al=octetul inferior din cuvantul superior
      sub esi,1
      movzx ax,al
      mov bl,10;bl=10
      cmp ax,10
      jb palindrom
      jae continua
      continua:
      cmp ax,100
      jb compara
      jae mai_mare_ca_100
      compara:
      div bl;al=cifra zecimala,ah=cifra unitara
      cmp al,ah
      je palindrom
      jne myendif
      mai_mare_ca_100:
      mov dl,100
      div bl;ah=cifra unitara
      mov bl,ah;bl=cifra unitara
      lodsb;al=octetul inferior din cuvantul superior
      sub esi,1
      movzx ax,al
      div dl;al=cifra sutelor
      cmp al,bl
      je palindrom
      jne myendif
      jmp myendif
      palindrom:
      movsb
      sub esi,1
      jmp myendif
      myendif:
      add esi,2
      loop repeta
      final:
    
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
