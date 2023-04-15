bits 32
global start
extern exit,fopen,fscanf,printf,fclose
import fscanf msvcrt.dll
import exit msvcrt.dll
import fopen msvcrt.dll
import printf msvcrt.dll
import fclose msvcrt.dll

segment data use32 class=data

 mod_acces db "r",0
 nume_fisier db "input.txt",0
 descriptor resd 1
 format_citire db "%c",0
 format_print db "%d ",0
 a resd 1
 min dd 16

 contor db 0
segment code use32 clas=code
      start:
      
   push dword mod_acces
   push dword nume_fisier
   call [fopen]
   add esp,4*2
   
   cmp eax,0
   je final
   
   mov [descriptor],eax
   
   repeta:
   push dword a
   push dword format_citire
   push dword [descriptor]
   call [fscanf]
   add esp,4*3
   
   cmp eax,-1
   je minim_final
   
  
   mov ebx,[a]
   cmp ebx," "
   jne mai_departe
   je afiseaza_minimul
   afiseaza_minimul:
   push dword[min]
   push dword format_print
   call [printf]
   add esp,4*2
   mov dword[min],16
   jmp repeta
   
   mai_departe:
   cmp ebx,"9"
   ja caracter
   jbe numar
   
   caracter:
   sub ebx,"A"
   add ebx,10
   cmp ebx,[min]
   jb mai_mic
   ja sari
   
   numar:
   sub ebx,"0"
   cmp ebx,[min]
   jb mai_mic
   ja sari
   
   mai_mic:
   mov [min],ebx
   
   sari:
   jmp repeta
   
   minim_final:
   push dword[min]
   push dword format_print
   call [printf]
   add esp,4*2
   
   final:
   push dword[descriptor]
   call [fclose]
   add esp,4
   
   
   
   
        
     
      
                   
      
      
      
      
      
      
 