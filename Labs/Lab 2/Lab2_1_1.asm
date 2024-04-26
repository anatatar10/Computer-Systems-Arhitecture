bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;unsigned
    ; ((a+b-c)*2 + d-5)*d  = 110 data types: a,b,c - byte, d - word 
    a db 2
    b db 4
    c db 3
    d dw 10

; our code starts here
segment code use32 class=code
    start:
        mov al, [a]
        add al, [b]
        sub al, [c]
        ;a+b-c = al
        mov bl, 2
        mul bl ; ax  = (a+b-c)*2
        add ax, [d]
        sub ax, 5
        mul word[d]
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
