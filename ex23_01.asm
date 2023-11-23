assume cs:code, ss:stack, ds:data

stack segment
    db 32 dup (0) 
stack ends

data segment
    db "basic", 0
    db "iNfOrMaTiOn", 0
    db "weLcoMe tO cHiNa", 0
    db 10, 13, '$'
data ends


code segment
start:
    mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax
    mov sp, 20H

    mov cx, 3
    mov si, 0
    mov ax, 0
    mov bx, 0


 s: 
    int 7CH
    call len
    add bx, ax
    loop s

    mov ah, 2
    mov bh, 0
    mov dh, 5
    mov dl, 0
    int 10H

    mov ax,data
    mov ds, ax
    mov dx, 0
    mov ah, 9
    int 21H

    mov ax, 4c00H
    int 21H    

len:
    push cx
    push si
    mov  si, 0

len0: mov cl, [bx+si]
      jcxz ok
      inc si
      jmp short len0
ok:
    inc si
    mov ax, si
    pop si
    pop cx
    ret


code ends

end start