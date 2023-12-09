assume cs:code, ss:stack, ds:data
stack segment
    db 32 dup (255)
stack ends

data segment
    db 32 dup (0)
data ends

code segment 
start:     
    mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax
    mov sp, 32
    mov si , 0

    mov ah, 0
    mov al, 41H
    
    call switch

    mov ax, 4c00H
    int 21H    

switch:
    jmp switch_start
    table dw push_char
switch_start:
    push bx

    cmp ah, 2
    ja switch_ret
    mov bl, ah
    mov bh, 0
    add bx, bx
    call word ptr table[bx]   

    jmp switch_ret

push_char:
    mov byte ptr ds:[si], al
    ret
switch_ret:
    pop bx
    ret


code ends

end start