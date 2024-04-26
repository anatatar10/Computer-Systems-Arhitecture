bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; a-(b-c)/d 
    ; a byte, b word, c byte, d doubleword
    a db 2
    b dw 4
    c db 3
    d dd 1

; our code starts here
segment code use32 class=code
    start:
        mov ax, [b]
        movsx bx, byte[c]
        sub ax, bx; ax = b-c
        movsx eax, ax; eax = ax 
        cdq; edx:eax
        idiv dword[d]; rez in eax 
        movsx ebx, byte[a] 
        sub ebx, eax 
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
