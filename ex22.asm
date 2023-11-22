assume cs:code, ss:stack, ds:data
stack segment
    dd 16 dup (0)
stack ends

data segment
   msg db 'Overflow!', 10, 13, '$'
data ends

code segment     
start:  
    mov ax, stack
    mov ss, ax
    mov ax, data
    mov ds, ax
    lea dx, msg
    mov ah, 9
    int 21H
    mov  ax, 4c00H
    int 21h 

code ends

end start