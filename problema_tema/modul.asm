bits 32      
segment data use32 
 stare db 0                   
segment code use32 public code
global stocare
stocare:  
;seteam sirul destinatie si sirul sursa
mov esi,[esp+8]
mov edi,[esp+4]   

;stocarea efectiva
repeta:

;conditie de oprire
cmp byte[esi],0
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
ret
