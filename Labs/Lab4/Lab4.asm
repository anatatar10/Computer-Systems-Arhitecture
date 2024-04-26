bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;a byte, b word, c word, d byte, e doubleword, f byte
    ; if a > (b-2) then e = (a+3)*2 – c else e = c/7; 1
    a db 2
    b dw 10
    c dw 7
    e dw 0

; our code starts here
segment code use32 class=code
    start:
        movsx ax, byte[a]
        mov bx, [b]
        sub bx, 2
        cmp ax, bx
        JG ramuranthen
        JLE ramuraelse
            ramuranthen:
                mov al, [a]
                add al, 3
                mov bl, 2
                imul al; ax (a+3)*2
                sub ax, [c]
                movsx eax, ax
                mov [e], eax
            jmp myendif
            ramuraelse:
                mov al, 7
                idiv al; al
                movsx eax, al
                mov [e], eax
            myendif:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
