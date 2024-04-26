bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; a byte, b word, c word, d byte, e doubleword, f byte
    ; if (d+a) % 7 = 0 then e = 12*b else e = c /11; 12 - 1
    a db 1
    d db 5
    b dw 1
    c dw 11

; our code starts here
segment code use32 class=code
    start:
        mov al, [a]
        add al, [d]
        movsx ax, al 
        mov bl, 7
        idiv bl; ah - rest
        cmp ah, 0
        JE ramurathen
        JNE ramuraelse
            ramurathen:
                mov al, 12
                imul byte[b]; ax
            jmp myendif
            ramuraelse:
                mov ax, [c]
                mov bl, 11
                idiv bl; al;
            myendif:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
