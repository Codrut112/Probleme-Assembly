; Se citeste de la tastatura un sir de numere in baza 10 fara semn. Sa se determine valoarea maxima din sir si sa se afiseze in fisierul max.txt (fisierul va fi creat) valoarea maxima, in baza 16

bits 32 
global start        

extern exit, gets, fopen, fprintf, fclose, printf
extern compara
              
import exit msvcrt.dll
import fprintf msvcrt.dll
import gets msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    s resb 100
    max dd 0
    print_format db "%x", 0
	mod_acces db "w", 0
	nume_fisier db "max.txt", 0
    descriptor dd 0

segment code use32 public code
    start:
        ; read the array
        push dword s
        call [gets]
        add esp, 4 * 1
        
        mov esi, s
        mov eax, 0
        repeta:
            ; break condition
            cmp byte[esi], '.'
            je final
            
            ; daca avem caracterul sptatiu => numar complet
            cmp byte[esi], ' '
            je compara
            
            mov bl, byte[esi]
            sub bl, '0' ; Convert the digit to a number
            mov cl, 10
            mul cl
            add al, bl 
            inc esi
            jmp repeta
            
            push eax
            push dword[max]
            call compara
            mov eax, 0
            inc esi

            jmp repeta
            final:
        push dword[max]
        push print_format
        call [printf]
        add esp, 4 * 2
        
        mov ebx, [max]
        pushad 
            
        push dword mod_acces
		push dword nume_fisier
		call [fopen]
		add esp, 4 * 2
		
        mov [descriptor], eax 
        cmp dword[descriptor], 0
		je final2
		
        popad
		push ebx
		push dword print_format
		push dword [descriptor]
		call [fprintf]
		add esp, 4 * 3
		
		push dword[descriptor]
		call [fclose]
		add esp, 4
        
        final2:
        push    dword 0      
        call    [exit]