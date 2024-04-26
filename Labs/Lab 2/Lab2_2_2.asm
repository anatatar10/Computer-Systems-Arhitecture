bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;  2/(a+b*c-9)-d;  = 1 a,b,c-byte; d-doubleword; 
    a db 4
    b db 2
    c db 3
    d dw 1

; our code starts here
segment code use32 class=code
    start:
        mov al, [b]
        mul byte[c]; ax = b*c
        movzx bx, byte[a]
        add ax, bx
        sub ax, 9
        mov bx, ax
        mov ax, 2
        mov dx, 0
        div bx
        sub ax, [d]
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
