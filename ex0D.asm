assume cs:code, ds:data, ss:stack

stack segment
    dw 0,0,0,0,0,0,0,0,0
stack ends

data segment
        db 0
data ends

code segment
start: 
    mov ax, data
    mov ds, ax

    mov ax, stack
    mov ss, ax
    mov sp, 10H
    mov cx, 3  

s:  push cx
    mov si, 0
    mov cx, 8        
s0: mov ax, 0
    mov [bx + si], ax
    add si, 2
    loop s0
    add bx, 10H
    pop cx
    loop s


mov ax, 4c00H
int 21H    

code ends

end start
