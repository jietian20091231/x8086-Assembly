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
    mov es, ax
    mov si, 16
    mov di, 32
    mov cx, 9
    std
    ; mov si, 0
    ; mov di, 16
    ; mov cx, 8
    ; cld
    rep movsw

    
      
ok: mov  ax, 4c00H
    int 21h 

code ends

end start