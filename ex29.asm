assume cs:code, ss:stack
stack segment
    db 128 dup (0)
stack ends

code segment 
start: 
    mov ax, stack
    mov ss, ax
    mov sp, 128
    mov ax, 0
    mov es, ax

    mov ah, 0
    int 16H
    
    mov ah, 1
    cmp al, 'r'
    je red
    cmp al, 'g'
    je green
    cmp al, 'b'
    je blue
    jmp short sret

red:
    shl ah, 1
green:
    shl ah, 1
blue:
    mov bx,0B800H
    mov es, bx
    mov si, 1
    mov cx, 2000
s:
    and byte ptr es:[si], 11111000B
    or es:[si], ah
    inc si
    inc si
    loop s


sret:    
    mov ax, 4C00H
    int 21H

code ends

end start