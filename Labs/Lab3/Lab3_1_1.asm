bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; (a*a-b+7)/(2+a)-c = -19, a-byte; b-doubleword, c-word
    a db -4
    b dd 5
    c dw 10

; our code starts here
segment code use32 class=code
    start:
        mov al, [a]
        imul byte[a] ; ax = a*a
        sub ax, [b]
        add ax, 7
        mov bl, 2
        add bl, [a] ; bl = 2+a
        idiv bl ; al = (a*a-b+7)/(2+a)
        movsx ax, al;
        sub ax, [c]
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
