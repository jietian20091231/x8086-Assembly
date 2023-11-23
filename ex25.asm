assume cs:code, ss:stack, ds:data
stack segment
    dd 16 dup (0)
stack ends

data segment
    dw 8 dup (0)
data ends

code segment 

start:   
    mov al, 08H
    out 42H, al
    out 42H, al
    mov ah, al
    or al, 3
    out 61H, al
    mov cx, 65535H
delay:
    nop
    loop delay
    mov al, ah
    out 61H, al    
    mov ax, 4c00H
    int 21H

code ends

end start