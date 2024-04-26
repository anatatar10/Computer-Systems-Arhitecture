bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; 200/b-c/(d+1)+e = -100 a,b-word; c,d-byte; e-doubleword;
    b dw -2
    c db 4
    d db 1
    e dd 2

; our code starts here
segment code use32 class=code
    start:
        mov ax, 200
        cwd;
        idiv word[b]; ax-200/b
        mov bx, ax
        mov cl, [d]
        add cl,1
        movsx ax, byte[c]
        idiv cl; al-c/(d+1)
        movsx ax, al
        sub bx, ax
        movsx eax, bx
        add eax, [e]
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
