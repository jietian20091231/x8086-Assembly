assume cs:code, ss:stack, ds:data
stack segment
    dd 16 dup (0)
stack ends

data segment
    db "WelcometoChina", 0
data ends

code segment 
start:
    mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax
    mov sp, 10H

    
    mov si, 0
    mov cx, 0
s:  mov cl, ds:[si]
    mov ch, 0
    jcxz ok
    and cl, 11011111b 
    mov byte ptr ds:[si], cl
    inc si
    jmp short s

ok: mov  ax, 4c00H
    int 21h 

code ends

end start