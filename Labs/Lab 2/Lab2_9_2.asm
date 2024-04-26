bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; (a-b+c*128)/(a+b)+e  =25; a,b-byte; c-word; e-doubleword;
    a db 4
    b db 2
    c dw 1
    e dd 4
    

; our code starts here
segment code use32 class=code
    start:
        mov bl, [a]
        sub bl, [b]
        mov ax, [c]
        mov cx, 128
        mul cx ; dx:ax = c*128
        push dx
        push ax
        pop eax
        movzx ebx, bl
        add ebx, eax ; ebx = (a-b+c*128) = 130
        mov eax, ebx
        mov bl, [a]
        add bl, [b]
        push eax
        pop ax
        pop dx
        movzx bx, bl
        div bx ;ax = (a-b+c*128) = 21
        movzx eax, ax
        add eax, [e]
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
