bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; 1/a+200*b-c/(d+1)+e  =203; a,b-word; c,d-byte; e-doubleword;
    a dw 1
    b dw 1
    c db 6
    d db 2
    e dd 4

; our code starts here
segment code use32 class=code
    start:
        mov ax, 1
        mov dx,0
        div word[a] ; al = 1/a
        mov bl, al
        movzx ebx, bl
        mov ax, 200
        mul word[b] ; dx:ax = 200*b
        push dx
        push ax
        pop eax
        add ebx, eax ; ebx = 1/a+200*b
        mov al, [d]
        add al, 1
        mov cl, al
        movzx ax, byte[c]
        div cl ; c/(d+1) = al
        movzx eax, al
        add ebx, eax
        add ebx, [e]
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
