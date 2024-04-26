bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;  a/b+c*d-b/c+e = 6 a,b,d-byte; c-word; e-doubleword;
    a db 4
    b db 2
    c dw 2
    d db 2
    e dd 1

; our code starts here
segment code use32 class=code
    start:
        movzx ax, byte[a]
        div byte[b] ; al = a/b
        mov bl, al; bl = a/b
        mov ax, [c]
        movzx cx, byte[d]
        mul cx ; dx:ax = c*d
        movzx ebx, bl
        push dx
        push ax
        pop eax
        add ebx, eax
        movzx ax, [b]
        mov dx, 0
        div word[c] ; ax = b/c
        movzx eax, ax
        sub ebx, eax
        add ebx, [e]
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
