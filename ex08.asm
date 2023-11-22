assume cs:code, ds:data

data segment
        db "basic"
        db "iNfOrMaTiOn"
data ends

code segment
start: 
        mov ax, data
        mov ds, ax 

        mov bx, 0
        mov cx, 5
     s: mov al, [bx]
        and al, 11011111b
        mov [bx], al
        inc bx
        loop s

        mov cx, 11
    s0: mov al, [bx]
        or al, 60H
        mov [bx], al
        inc bx
        loop s0 


mov ax, 4c00H
int 21H    

code ends

end start
