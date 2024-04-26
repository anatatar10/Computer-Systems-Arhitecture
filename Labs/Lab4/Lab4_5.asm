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
    ;if f % 5 = 0 then e = a/(4+b) else e = 2*(-a); -20
    a db 10
    b dw 1
    f db 1
    e dd 0

; our code starts here
segment code use32 class=code
    start:
        movsx ax, byte[f]
        mov bl, 5
        idiv bl; al:ah
        cmp ah, 0
        JE ramurathen
        JNE ramuraelse
            ramurathen:
                mov bx, [b]
                add bx, 4
                movsx ax, byte[a]
                cwd 
                idiv bx; ax
                movsx eax, ax
                mov [e], eax 
            jmp myendif
            ramuraelse:
                mov al, [a]
                neg al
                mov bl, 2
                imul bl;
                movsx eax, ax 
                mov [e], eax 
            myendif:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
