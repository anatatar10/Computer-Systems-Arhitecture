bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; A string of doublewords T is given. Compute string R containing only high bytes from high words from each doubleword from string S.

    ;If S = 12345678h, 1a2b3c4dh => D = 12h, 1ah
    s dd 12345678h, 1a2b3c4dh
    ls equ ($-s)/4
    d resb ls

; our code starts here
segment code use32 class=code
    start:
        mov esi, 3
        mov edi,0
        mov ecx, ls 
        repeta:
            mov al,[s+esi],
            mov [d+edi],al
            inc edi
            add esi, 4
        loop repeta
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
