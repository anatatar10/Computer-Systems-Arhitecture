bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
                          
                          extern exit, printf, gets
 
import exit msvcrt.dll
import printf msvcrt.dll
import gets msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;B4. A string of words S is given. Compute string D containing only high bytes multiple of 7 from string S.
    ;If S = 1735h, 0778h, 0E20h => D = 07h, 0Eh
    s dw 1735h, 0778h, 0E20h, 0707h
    ls equ ($-s)/2
    d resb ls
    
    mesajAfisare db "The multiples of 7 are: ", 0
    contor dd 0
    formatSir db '%d ',0
    sirPrintare resd 6
    newline db 10, 0

; our code starts here
segment code use32 class=code
    start:
        mov esi, 1
        mov edi, 0
        mov ecx, ls 
        mov ebp, 0
        repeta:
            mov al, [s+esi]
            cbw
            cwd
            mov bx, 7
            idiv bx ; al-cat, ah=rest 
            cmp dx, 0
            JE ADAUGA
            JNE NEXT
                ADAUGA:
                    mov al, [s+esi]
                    mov [d+edi], al
                    movzx eax, al
                    mov[sirPrintare+ebp], eax
                    inc dword[contor]
                    add edi, 1
                NEXT:
                    ADD ESI, 2
        loop repeta

     push dword mesajAfisare
    call [printf]
    add esp, 4*1
    
    push dword newline        
    call [printf]
    add esp, 4*1
    
    mov ecx, [contor]
    mov esi, 0
    repetaafisareP:
        pushad
        mov eax, dword[sirPrintare+esi]
        push eax
        push dword formatSir
        call [printf]
        add esp, 4*2
        popad
           
        add esi, 4
    loop repetaafisareP
    
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
