bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; (a+b/c-1)/(b+2) - d = -5; a-doubleword; b-byte; c, d -word; 
    a dd -4
    b db 2
    c dw 2
    d dw 4
   
; our code starts here
segment code use32 class=code
    start:
        movsx ax, [b]
        cwd;dx:ax = b 
        idiv word[c] ; ax = b/c
        movsx eax, ax 
        add eax, [a] ; eax = a+b/c
        sub eax, 1; eax = a+b/c-1
        mov bl, [b]
        add bl, 2 
        movsx bx, bl ; bx = b+2
        push eax 
        pop ax 
        pop dx 
        idiv bx ; ax = (a+b/c-1)/(b+2)
        sub ax, [d]
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
