assume cs:code, ss:stack, ds:data
stack segment
    dd 16 dup (0)
stack ends

data segment
    dd 16 dup (0)
data ends

code segment 
start:
    mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax
    mov sp, 10H
    
    ; mov cx, 6    
    ; mov ax, 1
    ; call add_s    
    ; mov  bx, ax

    mov word ptr ds:[0], 1
    mov word ptr ds:[2], 2

    mov ax, ds:[0]
    add ax, ds:[2]


    mov  ax, 4c00H
    int 21h

; add_s: add ax, ax
;        loop add_s
;        ret    

code ends

end start