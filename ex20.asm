assume cs:code, ss:stack, ds:data
stack segment
    dd 16 dup (0)
stack ends

data segment
    dw 8 dup (0)
data ends

code segment 

showbyte:
    jmp short show
    table db '0123456789ABCDEF'
show:     
    push es
    push cx    
    push bx

    mov ah, al
    mov cl, 4
    shr ah, cl
    and al, 00001111b

    mov bl, ah
    mov bh, 0
    mov ah, table[bx]

    mov bl, al
    mov bh, 0
    mov al, table[bx]

    mov bx, 0B800H
    mov es,bx
    mov es:[160*12 + 40 *2], ah
    mov es:[160*12 + 40 *2 + 2], al

    pop bx
    pop cx
    pop es
    ret

start:  
    mov al, 4AH
    call showbyte    
    mov  ax, 4c00H
    int 21h 

code ends

end start