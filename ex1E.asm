assume cs:code, ss:stack, ds:data
stack segment
    dd 16 dup (0)
stack ends

data segment
    dw 8 dup (0)
data ends

code segment 
    a db 1, 2, 3, 4, 5, 6, 7, 8
    b dw 0
start:  
    mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax
    mov si, offset a
    mov bx, offset b 
    mov cx, 8   
s:  mov al, a[si]
    mov ah, 0
    add b, ax
    inc si
    loop s
    mov ax, b
    mov ds:[0], ax
ok: mov  ax, 4c00H
    int 21h 

code ends

end start