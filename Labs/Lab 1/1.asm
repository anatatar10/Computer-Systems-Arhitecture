bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;a –word, b – byte, c - word, d – byte
    ; a+b-7-(c+d)
    a dw 10
    b db 5
    c dw 2
    d db 2

; our code starts here
segment code use32 class=code
    start:
        mov bl, [b]
        movzx bx, bl
        mov ax, [a]
        add ax, bx
        sub ax, 7
        mov dl, [d]
        movzx dx, dl
        mov cx, [c]
        add cx, dx
        sub ax, cx
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
