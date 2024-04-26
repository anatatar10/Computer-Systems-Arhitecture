bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;(a-2)/(b+c)+a*c+e = 25; a,b-byte; c-word; e-doubleword; 
    a db 10
    b db 2
    c dw 2
    e dd 3
; our code starts here
segment code use32 class=code
    start:
        mov al, [a]
        sub al, 2
        movzx bx, byte[b]
        add bx, [c]
        movzx ax, al
        mov dx, 0
        div bx ; ax = (a-2)/(b+c)
        mov bx, ax; bx = (a-2)/(b+c)
        movzx ebx, bx
        movzx ax, byte[a]
        mul word[c] ; dx:ax = a*c
        push dx
        push ax
        pop eax
        add ebx, eax
        add ebx, [e]
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
