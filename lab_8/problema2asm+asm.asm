bits 32
global start
extern printf,gets
import printf msvcrt.dll
import gets msvcrt.dll
segment data use32 class=data
format_citire db  "%s",0
mesaj_citire db  'introduceti sirul:',0
mesaj_afisare db "sirul este ",
s resb 100
segment code use32 class=code 
start:

push dword mesaj_citire
call [printf]
add esp,4

push dword s 
call [gets]
add esp,4

push dword s
push dword mesaj_afisare
call [printf]
add esp,4*2



