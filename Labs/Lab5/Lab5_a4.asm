bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; A string of bytes A is given. Construct string B such that each element from B represent the product of two consecutive elements from string A.

    ;If A = 2, 4, 5, 7 => B = 8, 20, 35 ; 8,14,23 in hexadecimal
    s db 2,4,5,7
    ls equ $-s
    d resb ls 

; our code starts here
segment code use32 class=code
    start:
        mov esi,0
        mov ecx,ls-1
        repeta:
            mov al,[s+esi]
            mov bl,[s+esi+1]
            imul bl; ax
            mov [d+esi], al
            inc esi 
        loop repeta
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
