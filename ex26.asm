assume cs:code, ss:stack, ds:data
stack segment
    dd 16 dup (0)
stack ends

data segment
    dw 8 dup (0)
data ends

code segment 

start:   
    mov al, 0
    out 70H, al
    in al, 71H

    mov ah,al
    mov cl, 4
    shr ah, cl
    and al, 00001111B

    add ah, 30H
    add  al, 30H

    mov bx, 0B800H
    mov es, bx
    mov byte ptr es:[160*12 + 40*2], ah
    mov byte ptr es:[160*12 + 40*2 + 2],al
    
    mov ax, 4C00H
    int 21H


code ends

end start