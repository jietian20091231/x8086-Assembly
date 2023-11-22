assume cs:code, ds:data

data segment
        db "BaSiC"
        db "MinIX"
data ends

code segment
start: 
        mov ax, data
        mov ds, ax 

        mov bx, 0
        mov cx, 5
     s: mov ah, [bx]
        mov al, [bx + 5]

        and ah, 11011111b
        or  al, 00100000b
        mov [bx], ah
        mov [bx + 5], al
        inc bx
        loop s


mov ax, 4c00H
int 21H    

code ends

end start
