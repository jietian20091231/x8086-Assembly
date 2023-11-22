assume cs:codesg

codesg segment
        dw 0123H, 0456H, 0789H, 0ABCH, 0DEFH, 0FEDH, 0CBAH, 0987H

start:  mov bx, 0
        mov ax, 0
        mov cx, 8

s:      add ax, cs:[bx]    
        add bx, 2
        loop s

mov ax, 4c00H
int 21H

codesg ends

end start
