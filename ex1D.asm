assume cs:code, ss:stack, ds:data
stack segment
    dd 16 dup (0)
stack ends

data segment
    db 'Welcome to masm!'
    db 16 dup (0)
data ends

code segment 
start:
    mov ax, stack
    mov ss, ax
    mov sp, 10H 
    mov ax, data
    mov ds, ax
    mov ax, 0B800H
    mov es, ax
    mov si, 0
    mov di, 160*12+80-16
    mov cx, 16
w:  mov al, [si]
    mov es:[di], al
    inc di
    mov al, 71H
    mov es:[di], al
    inc si
    inc di
    loop w

    
      
ok: mov  ax, 4c00H
    int 21h 

code ends

end start