assume cs:codesg

codesg segment
        mov ax, 0ffffh
        mov ds, ax
        
        mov bx, 0
        mov dx, 0
        mov cx, 12

    s:  mov al, ds:[bx]
        mov ah, 0
        add dx, ax
        inc bx
        loop s

        mov ax, 4c00H
        int 21H

codesg ends

end
