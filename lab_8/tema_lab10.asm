bits 32

global start

extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
;4. Se dau doua numere naturale a si b (a, b: word, definite in segmentul de date). Sa se calculeze produsul lor si sa se afiseze in urmatorul format: "<a> * <b> = <result>"
; Exemplu: "2 * 4 = 8"
; Valorile vor fi afisate in format decimal (baza 10) cu semn.
segment data use32 class=data

    format db "%d", 0
    citire_a db "introduceti a: ", 0
    citire_b db "introduceti b: ", 0
    format_print db "%d * %d = %d", 0
    a dw 0
    b dw 0
    s dd 0

segment code use32 class=code
start:
    ;printf("Introduceti a:")
    push dword citire_a
    call [printf]
    add esp, 4
    
    ;apel scanf(%d,a)
    push dword a
    push dword format
    call [scanf]
    add esp, 4*2 
    
    
    push dword [a];il salvez pe stiva pe a
    
    ;apel printf("introduceti b:")
    push dword citire_b
    call [printf]
    add esp, 4
    
    ;apel scanf(%d,b)
    push dword b
    push dword format
    call [scanf]
    add esp, 4*2  ;citim b
    
    pop edx;edx=[a]
    mov ebx, 0
    add ebx, [b];edx=[b]
    
    mov eax, edx;eax=[a]
    push edx;salvez [a] pe stiva
    mul bx;eax=[a]*[b]
    pop edx;edx=[a]
    
   ;apel printf("%d * %d = %d",a,b,a*b)
    push eax
    push ebx
    push edx
    push dword format_print
    call [printf]
    add esp, 4*4


    push dword 0
    call [exit]