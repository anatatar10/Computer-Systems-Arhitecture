bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; 20/(a+b*c-9)-d = -5; a,b,c-byte; d-doubleword; 
    a db -3
    b db 4
    c db -1
    d db 4

; our code starts here
segment code use32 class=code
    start:
        mov al, [b]
        imul byte[c] ; ax=b*c
        movsx bx, [a]
        add bx, ax
        sub bx, 9 ; bx = (a+b*c-9)-d
        mov ax, 20
        cwd
        idiv bx ; ax = 20/(a+b*c-9)
        movsx bx, byte[d]
        sub ax, bx
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
