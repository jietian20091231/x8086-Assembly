assume cs:code, ds:data, ss:stack

stack segment
    dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
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
    mov si, 0

s:  mov bx, si    
    add si, 10H
    push cx
    push si       
    mov cx, 8
    mov si, 0
s0: mov ax, 0
    mov [bx + si], ax
    add si, 2
    loop s0
    pop si
    pop cx
    loop s


mov ax, 4c00H
int 21H    

code ends

end start
