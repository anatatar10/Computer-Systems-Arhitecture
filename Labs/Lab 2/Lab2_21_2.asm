bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; (a*a/b+b*b)/(2+b)+e = 5; a-byte; b-word; e-doubleword; 
    a db 2
    b db 2
    e dw 4
    

; our code starts here
segment code use32 class=code
    start:
        mov al, [a]
        mul byte[a]; ax = a*a
        div byte[b] ; al a*a/b
        mov bl, al
        mov al, [b]
        mul byte[b] ; ax=b*b
        movzx bx, bl
        add bx,ax
        mov ax, bx
        mov bl, 2
        add bl, byte[b]
        div bl ; al = (a*a/b+b*b)/(2+b)
        movzx eax, al
        add eax, [e]
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
