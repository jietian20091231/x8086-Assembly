assume cs:code, ss:stack, ds:data
stack segment
    dd 16 dup (0)
stack ends

data segment
    dw 2 dup (65535)
data ends

code segment 
    a db 1, 2, 3, 4, 5, 6, 7, 8
    b dw 0
    c dw a, b ; ==> c dw offset a, offset b
start:  
    mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax

    mov ax, c[0]
    mov ds:[0], ax
    mov ax, c[2]
    mov ds:[2], ax

ok: mov  ax, 4c00H
    int 21h 

code ends

end start