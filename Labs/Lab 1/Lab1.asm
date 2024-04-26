bits 32 ; assembling for the 32 bits architecture


; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dw 10
    b db 6
    d db 20

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; zona secventa de cod
        ; 6 + d
        mov al, [d] ; in al transfer valoarea variabilei d; al = 20
        add al, 6 ; al = 20+6 = 26
        
        
        ;6+d-b
        sub al, [b] ; al = al - b = 26-6 = 20
        
        ;(6+d-b)-2
        sub al, 2 ;  al = al - 2 = 20 - 2 = 18
        
        
        ;(6+d-b)-2 + a
        ;   al     + a
        ;   8 biti + 16 biti
        movzx ax, al
        add ax, [a] ; al = al + a = 18 + 10 = 28
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
