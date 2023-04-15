bits 32 

global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fread,printf
import exit msvcrt.dll 
import fopen msvcrt.dll 
import fread msvcrt.dll 
import fclose msvcrt.dll 
import printf msvcrt.dll

; our data is declared here 
segment data use32 class=data
    nume_fisier db "in.txt", 0   
    mod_acces db "r", 0             
    descriptor_fis dd -1            
    nr_car_citite dd 0             
    len equ 100                     
    buffer resb len      
        nr_impare dd 0
  
    impare db "13579",0
    len_impare equ $ - impare
    format_output db "Numarul de cifre impare este: %d", 0

; our code starts here
segment code use32 class=code
    start:
        ;apel fopen("in.txt","r")
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        ; verificam daca functia fopen a creat cu succes fisierul (daca EAX != 0)
        cmp eax, 0                  
        je final
        
        mov [descriptor_fis], eax   
        
        
        
        bucla:
            
            ;apel fread(buffer,1,nr_car_citite,descriptor_fis)
            push dword [descriptor_fis]
            push dword len
            push dword 1
            push dword buffer
            call [fread]
            add esp, 4*4
            
            
            cmp eax, 0          
            je cleanup

            mov [nr_car_citite], eax        
            mov ecx,eax 
                        procesare_caracter:
                mov bl, [buffer + ECX -1] 
                
                
                
                    cmp bl,"1"
                    je adauga
                    cmp bl,"3"
                    je adauga
                    cmp bl,"5"
                    je adauga
                    cmp bl,"7"
                    je adauga
                    cmp bl,"9"
                    je adauga
                   
                    jmp nu_adauga
                    adauga:
                    add dword[nr_impare],1
                 nu_adauga:
                
                loop procesare_caracter
   

            jmp bucla
        
      cleanup:
        ;apel fclose("in.txt")
        push dword [descriptor_fis]
        call [fclose]
        add esp, 4
        
      final: 
           ;apel printf("Numarul de cifre impare este: %d",nr_impare)
            push dword [nr_impare]
            push dword format_output 
            call [printf]

        ; exit(0)
        push    dword 0      
        call    [exit]  