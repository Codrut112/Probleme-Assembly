bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,gets,printf             ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll 
import gets msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
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
segment code use32 class=code
    start:
    ;afisam mesajul de citire
push dword mesaj_citire
call [printf]
add esp,4

;citirea efectiva a sirului
push dword s1 
call [gets]
add esp,4


;seteam sirul destinatie si sirul sursa
mov esi,s1
mov edi,s2

;stocarea efectiva
repeta:

;conditie de oprire
cmp byte[esi],'g'
je final

;daca intalnim caracterul spatiu inseamna ca avem un numar complet
cmp byte[esi],' '
je adauga_sir

;daca intalnim caracterul "-" inseamna ca avem un un numar negativ
cmp byte[esi],'-'
je seteaza_negativ

;punem cifra in dl
mov dl,byte[esi]

cmp byte[stare],1
je negativ
jne pozitiv

;actualizam numarul (negativ)
negativ:
movzx ebx,dl
add ebx,ebx;ebx=ebx*2
mov ecx,ebx;ecx=ebx*2
add ebx,ebx;ebx=ebx*4
add ebx,ebx;ebx=ebx*8
add ebx,ecx;ebx=ebx*10
sub ebx,eax
inc esi 
jmp repeta

;actualizam numarul (pozitiv)
pozitiv:
movzx eax,dl
add ebx,ebx;ebx=ebx*2
mov ecx,ebx;ecx=ebx*2
add ebx,ebx;ebx=ebx*4
add ebx,ebx;ebx=ebx*8
add ebx,ecx;ebx=ebx*10
add ebx,eax
inc esi
jmp repeta


;setam numarul ca fiind negativ
seteaza_negativ:
mov byte[stare],1
inc esi
jmp repeta

;adaugam numarul in sir
adauga_sir:
mov dword[edi],ebx
mov ebx,0
add edi,4
inc esi
mov byte[stare],0
jmp repeta




     
     
     
     
     
     
     
     
     
     
        final:
        
        
        
        
   
     
     
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
