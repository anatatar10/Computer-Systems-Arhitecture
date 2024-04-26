bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; A string of bytes A is given. Construct string B containing only negative values from string A.


    ;If A = 17, 4, 2, -2, -1 => B = -2, -1
    
    s db 17,4,2,-2,-1
    ls equ $-s
    d resb ls

; our code starts here
segment code use32 class=code
    start:
        mov esi, 0
        mov edi,0
        mov ecx,ls
        repeta:
            mov al, [s+esi]
            cmp al, 0
            JL ramurathen
            JGE ramuraelse
                ramurathen:
                    mov al, [s+esi]
                    mov [d+edi], al 
                    inc edi
                ramuraelse:
                    inc esi
        loop repeta 
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
