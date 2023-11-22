assume cs:code, ds:data, ss:stack

stack segment
    dw 0,0,0,0,0,0,0,0
stack ends

data segment
        db 'ibm             '
        db 'dec             '
        db 'dos             '
        db 'vax             '
data ends

code segment
start: 
    mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax
    mov sp, 10H

    mov bx, 0
    mov cx, 4

s0: push cx
    mov si, 0
    mov cx, 3
s:  mov al, [bx+si]
    and al, 11011111b
    inc si
    loop s
    add bx, 10H
    pop cx
    loop s0  

mov ax, 4c00H
int 21H    

code ends

end start
