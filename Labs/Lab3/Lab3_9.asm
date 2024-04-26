bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; (a-b+c*128)/(a+b)+e = 25; a,b-byte; c-word; e-doubleword
    a db 5
    b db 1
    c dw 1
    e dd 3

; our code starts here
segment code use32 class=code
    start:
        mov al, [a]
        sub al, [b]; al=a-b
        mov bl, al; bl=a-b
        mov ax, 128
        imul word[c];dx:ax=c*128
        push dx
        push ax
        pop eax
        movsx ebx, bl
        add eax, ebx; eax = a-b+c*128
        push eax
        pop ax
        pop dx
        mov bl, [a]
        add bl, [b]; al=a+b
        movsx bx, bl
        idiv bx; ax
        movsx eax, ax
        add eax, [e]
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
