bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; d-(7-a*b+c)/a+5 = -2; a,c-byte; b-word; d-doubleword;
    a db 2
    b dw 2
    c db -5
    d dd 2

; our code starts here
segment code use32 class=code
    start:
        movsx ax, byte[a]
        imul word[b]; dx:ax = a*b
        push dx 
        push ax 
        pop ebx 
        mov ax, 7
        cwde; eax = 7
        sub eax, ebx; eax = 7-a*b
        mov ebx, eax; ebx = 7-a*b
        movsx ax, byte[c]
        cwde; eax = c
        add eax, ebx;
        push eax 
        pop ax
        pop dx
        movsx bx, byte[a];
        idiv bx; ax = (7-a*b+c)/a
        add ax, 5
        movsx eax, ax
        mov ebx, [d]
        sub ebx, eax; ebx

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
