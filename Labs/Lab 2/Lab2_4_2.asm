bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;  (a*2+b/2+e)/(c-d) = 10/2=5; a-word; b,c,d-byte; e-doubleword; 
    a dw 2
    b db 10
    c db 4
    d db 2
    e dd 1
; our code starts here
segment code use32 class=code
    start:
        mov ax, 2
        mul word[a];dx:ax = a*2
        mov cx, dx
        mov bx, ax
        push cx
        push bx
        pop ebx
        movzx ax, byte[b]
        mov cl, 2
        div cl ; al = b/2
        movzx eax, al
        add eax, ebx
        add eax, [e] ; eax  = (a*2+b/2+e)
        movzx bx, [c]
        movzx cx, [d]
        sub bx, cx
        push eax
        pop ax
        pop dx
        div bx ; rezultat in ax
   
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
