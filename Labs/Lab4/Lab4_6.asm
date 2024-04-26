bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; a byte, b word, c word, d byte, e doubleword, f byte
    ; if (c-a) <= 10 then e = 5* (b+1) else e = 12/(a-6); 
    a db 1
    c dw 12
    b dw 1
    e dd 0

; our code starts here
segment code use32 class=code
    start:
        movsx ax, byte[a]
        neg ax
        add ax, [c]
        cmp ax, 10
        JLE ramurathen
        JG ramuraelse
            ramurathen:
                mov bx, [b]
                add bx, 1
                mov ax, 5
                imul bx; dx:ax 
                push dx 
                push ax 
                pop eax 
                mov [e], eax 
            jmp myendif
            ramuraelse:
                mov bl, [a]
                sub bl, 6
                mov ax, 12
                idiv bl;
                movsx eax, al 
                mov [e], eax
            myendif:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
