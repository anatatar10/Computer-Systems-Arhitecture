bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; (a*2+b/2+e)/(c-d) + e = 6; a-word; b,c,d-byte; e-doubleword
    a dw -2 
    b db 3
    c db 3
    d db 1
    e dd 5

; our code starts here
segment code use32 class=code
    start:
        mov ax, 2
        imul word[a]; dx:ax = a*2
        push dx 
        push ax 
        pop ebx ;ebx = a*2
        movsx ax, [b]
        mov cl, 2
        idiv cl ; ax = b/2 
        movsx eax, ax 
        add ebx, eax ; a*2+b/2
        add ebx, [e] ; ebx = a*2+b/2
        mov al, [c]
        sub al, [d]
        movsx ax, al 
        mov bx, ax ;bx = c-d
        push ebx 
        pop ax 
        pop dx 
        idiv bx ; ax  = (a*2+b/2+e)/(c-d)
        movsx eax, ax 
        add eax, [e]
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
