bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; (18-a*b*2+c)/d + e = 11; a,b,d-byte; c-doubleword, e - word
    a db -2
    b db 3
    d db 5
    c dd 2
    e dw 5

; our code starts here
segment code use32 class=code
    start:
        mov al, [a]
        imul byte[b] ; ax = a*b
        mov bx, 2
        imul bx ; dx:ax = a*b*2
        mov bx, ax 
        mov cx, dx 
        ; 18 -> dx:ax
        mov ax, 18
        cwd
        ;dx:ax
        ;cx:bx
        sub ax, bx 
        sbb dx, cx
        mov ebx, [c]
        push ebx 
        pop bx 
        pop cx 
        add ax, bx 
        adc dx, cx 
        movsx bx, [d]
        idiv bx ; ax = (18-a*b*2+c)/d
        add ax, [e]
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
