bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; [-1+d-2*(b+1)]/a = 0 data types: a,b,c - byte, d - word 
    a db 3
    b db 2
    d dw 10
    

; our code starts here
segment code use32 class=code
    start:
        mov bx, [d]
        sub bx, 1
        mov al, [b]
        add al, 1
        mov cl, 2
        mul cl; ax = 2*(b+1)
        sub bx, ax
        mov ax, bx
        div byte[a]
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
