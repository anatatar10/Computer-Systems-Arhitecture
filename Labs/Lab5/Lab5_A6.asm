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
    ; A6. A string of bytes A is given. Construct string B containing only positive values from string A.
    ; If A = 17, 4, 2, -2, -1 => B = 17, 4, 2
    ; B in hexa: 11, 4, 2
    s db 17, 4, 2, -2, -1
    ls equ $-s
    d resb ls 
    
    mesajAfisare db "The positive no are: ", 0
    contor dd 0
    formatSir db '%d ',0
    sirPrintare resd 6
    newline db 10, 0
   
; our code starts here
segment code use32 class=code
    start:
        mov esi, 0
        mov edi, 0
        mov ebp, 0
        mov ecx, ls
        repeta:
            mov al, [s+esi]
            cmp al, 0
            JGE ADAUGA
            JL NEXT
                ADAUGA:
                    mov al, byte[s+esi] 
                    mov [d+edi], al
                    movzx eax, al
                    mov dword[sirPrintare+ebp],eax
                    inc dword[contor]
                    add esi, 1
                    add edi, 1
                    add ebp, 4
                JMP myendif
                NEXT:
                    add esi, 1
                myendif:
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
