assume cs:codesg

codesg segment
        mov ax, 0ffffh
        mov ds, ax
        mov bx, 6
        mov al, ds:[bx]
        mov ah, 0

        mov dx, 0
        mov cx, 3
      
     s: add dx, ax
        loop s  

        mov ax, 4c00H
        int 21H

codesg ends

end
