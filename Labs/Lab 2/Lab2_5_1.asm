bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; [d-2*(a-b)+b*c]/2 = 3 data types: a,b,c - byte, d - word 
    a db 4
    b db 2
    c db 2
    d dw 6

; our code starts here
segment code use32 class=code
    start:
        mov al, [a]
        sub al, [b]
        mov bl, 2
        mul bl ; ax = 2*(a-b)
        mov bx, [d]
        sub bx, ax
        mov al, [b]
        mul byte[c] ; ax=b*c
        add bx, ax
        mov ax, bx
        mov bl, 2
        div bl ; al - rez
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
