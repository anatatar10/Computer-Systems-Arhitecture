bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; 3*[20*(b-a+2)-10*c]+2*(d-3) = 62 data types: a,b,c - byte, d - word 
    a db 2
    b db 4
    c db 6
    d dw 4

; our code starts here
segment code use32 class=code
    start:
        mov al, [b]
        sub al, [a]
        add al, 2
        mov bl, 20
        mul bl; ax = 20*(b-a+2)
        mov bx, ax ; bx = 20*(b-a+2)
        mov al, 10
        mul byte[c] ; ax = 10*c
        sub bx, ax ; bx = 20*(b-a+2)-10*c = 20
        mov ax, 3
        mul bx ; dx:ax = 60
        push dx
        push ax
        pop ebx
        mov ax, [d]
        sub ax, 3
        mov cx, 2
        mul cx ; dx:ax  = 2*(d-3)
        push dx
        push ax
        pop eax
        add ebx, eax
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
