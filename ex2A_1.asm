assume cs:code, ss:stack, ds:data
stack segment
    db 32 dup (255)
stack ends

data segment
    db 32 dup (0)
data ends

code segment 
start:     
    mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax
    mov sp, 32

    mov ax, 0
    push ax

    mov ax, 1
    push ax

    mov ax, 2
    push ax

    call s0

    pop  ax
    pop  ax
    pop  ax

    mov ax, 4C00H
    int 21H

s0:
    push ax
    mov ax, 4
    push ax
    pop ax
    pop ax
    ret

code ends

end start