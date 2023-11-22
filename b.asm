assume cs:code, ss:stack, ds:data
stack segment
    dd 16 dup (0)
stack ends

data segment
    dd 16 dup (0)
data ends

code segment 
start:
    mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax
    mov sp, 10H

    ; mov ax, 0
    ; mov al, 100
    ; mov bl, 10
    ; mul bl
    ; mov word ptr ds:[0], ax

    mov ax, 10000
    mov bx, 100
    mul bx

    mov word ptr ds:[2], dx
    mov word ptr ds:[0], ax

    mov  ax, 4c00H
    int 21h
 

code ends

end start