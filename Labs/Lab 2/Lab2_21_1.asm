bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;d-[3*(a+b+2)-5*(c+2)] = 11 data types: a,b,c - byte, d - word
    a db 2
    b db 4
    c db 2
    d dw 15
    
; our code starts here
segment code use32 class=code
    start:
        mov al, [a]
        add al, [b]
        add al, 2
        mov bl, 3
        mul bl; ax = 3*(a+b+2)
        mov bx, ax; bx = 3*(a+b+2)
        mov al, [c]
        add al, 2
        mov cl, 5
        mul cl; ax = 5*(c+2)
        sub bx, ax 
        mov ax, [d]
        sub ax, bx;
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
