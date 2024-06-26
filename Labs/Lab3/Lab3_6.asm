bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; a+c*d-b/(c+e) = -2+4+12/4 = 5; a,b,d-byte; c-word; e-doubleword;
    a db -2 
    b db -12
    c dw 2 
    d db 2
    e dd 2

; our code starts here
segment code use32 class=code
    start:
        movsx ax, byte[d]
        imul word[c] ; dx:ax = c*d
        push dx 
        push ax
        pop eax 
        movsx ebx, byte[a]
        add ebx, eax ; ebx = a+c*d
        movsx ecx, word[c]
        add ecx, [e] ; ecx = c+e
        movsx eax, byte[b]
        cdq ; edx:eax = b
        idiv ecx ; eax = b/(c+e)
        sub ebx, eax
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
