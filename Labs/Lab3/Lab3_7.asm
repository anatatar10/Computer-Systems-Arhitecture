bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; (a-2)/(b+c)+a*c+e = -9 a,b-byte; c-word; e-doubleword;
    a db -4
    b db 3
    c dw 3
    e dd 3

; our code starts here
segment code use32 class=code
    start:
        movsx ax, byte[a]
        sub ax, 2
        cwd;
        movsx bx, byte[b]
        add bx, [c]
        idiv bx; ax-rez
        mov bx, ax; bx = (a-2)/(b+c)
        movsx ax, byte[a]
        imul word[c]; dx:ax
        push dx 
        push ax
        pop eax
        add eax, [e]
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
