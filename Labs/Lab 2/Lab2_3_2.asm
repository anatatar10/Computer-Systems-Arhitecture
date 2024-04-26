bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;  (8-a*b*100+c)/d = 5 a,b,d-byte; c-doubleword
    a db 0
    b db 1
    c db 2
    d dw 2

; our code starts here
segment code use32 class=code
    start:
        mov al, 0
        mul byte[b];ax=a*b
        mov bx, 100
        mul bx;dx:ax=a*b*100
        push dx
        push ax
        pop ebx
        mov eax, 8
        sub eax, ebx
        movzx ebx, byte[c]
        add eax, ebx;(8-a*b*100+c) = eax
        push eax
        pop ax
        pop dx
        div word[d]
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
