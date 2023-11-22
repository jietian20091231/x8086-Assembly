assume cs:code, ss:stack, ds:data
stack segment
    dd 16 dup (0)
stack ends

data segment
    dw 8 dup (0)
data ends

code segment 

do0:  
    jmp short do0start
    msg db 'Overflow!'
do0start:     
    ; push es
    ; push cx    
    ; push bx
    ; push si
    ; push di
    ; push ax
    ; push ds
    
    mov ax, cs
    mov ds, ax
    mov bx, 0B800H
    mov es,bx
    mov si,202H
    mov di, 0
    mov cx, 9
    mov ah, 0

s:  
    mov al, [si]
    mov es:[160*12 + 36 * 2 + di], al
    inc si
    inc di
    inc di
    loop short s

    ; pop ds
    ; pop ax
    ; pop di
    ; pop si
    ; pop bx
    ; pop cx
    ; pop es
    mov  ax, 4c00H
    int 21h
do0end: nop

start:
    mov ax, stack
    mov ss, ax
    mov ax, data
    mov ds, ax

    ; mov ax, offset do0
    ; mov ax, offset msg - offset do0

    ;call do0
inst:
    mov ax, cs
    mov ds, ax
    mov si, offset do0
    mov ax, 0
    mov es, ax
    mov di, 200H
    mov cx, offset do0end - offset do0
    cld
    rep movsb

    mov word ptr es:[0 * 4], 200H   ;IP
    mov word ptr es:[0 * 4 + 2], 0  ;CS
    
    mov ax, 4c00H
    int 21H

code ends

end start