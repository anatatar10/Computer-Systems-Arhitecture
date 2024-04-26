bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; (100*a+d+5-75*b)/(c-5) = 12 data types: a,b,c - byte, d - word 
    a db 2
    b db 2
    c db 10
    d dw 5
        
; our code starts here
segment code use32 class=code
    start:
        mov al, 100
        mul byte[a] ; ax = 100*a
        add ax, [d]
        add ax, 5
        mov bx, ax
        mov al, 75
        mul byte[b]
        sub bx, ax ; ax = (100*a+d+5-75*b)
        mov ax, bx
        mov bl, [c]
        sub bl, 5
        div bl
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
