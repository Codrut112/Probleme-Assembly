bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,gets,printf,stocare             ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll 
import gets msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 
   mesaj_citire db "sirul este:",0
   s1 resb 100
   s2 resb 100
   ls resb 1
   stare db 0
   cifra db 0
   mesaj_afisare db "sirul este %s",0
   contor db 0
   format_citire db "%s"
   format_print db "da %d",0

; our code starts here
segment code use32 public code
    start:
    ;afisam mesajul de citire 
push dword mesaj_citire
call [printf]
add esp,4

;citirea efectiva a sirului
push dword s1 
call [gets]
add esp,4

push s1
push s2
call stocare
add esp,4*2

push dword 0
call [exit]