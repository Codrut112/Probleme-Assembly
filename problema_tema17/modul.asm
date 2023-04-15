bits 32 

global compara

segment data use32 class=data
    max resd 1

segment code use32 public code
    compara:
        mov ebx, [esp + 4]
        mov eax, [esp + 8]
    
        cmp eax, ebx
        ja atribuire
        jna continue
        atribuire:
            mov ebx, eax
            jmp continue
        continue:
        ret