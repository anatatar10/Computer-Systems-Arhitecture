bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s db 10, 11, 12
    ls equ $-s
    d resb ls
    aux db 3
    

; our code starts here
segment code use32 class=code
    start:
        ;registri index
        ;esi - extended source index
        ;edi - extended destination index
        mov esi, 0
        mov al, byte[s+esi] ; transfera in al byte[s+esi]
        ;al<-byte[e+esi]
        mov edi,1
        mov byte[d+edi], al
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program