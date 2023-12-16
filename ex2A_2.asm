assume cs:code, ss:stack, ds:data
stack segment
    db 32 dup (255)
stack ends

data segment
    db 32 dup (0)
data ends

code segment 
    top dw 0
start:     
    mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax
    mov sp, 32

    ;input A
    mov ah, 0
    mov al, 41H
    call switch

    ;input B
    mov ah, 0
    mov al, 42H
    call switch


    ;print AB
    mov ah, 2
    mov al, 0
    mov dx, 160*12
    call switch

    ;backspace
    mov ah, 1
    mov al, 0
    call switch

    ;print A
    mov ah, 2
    mov al, 0
    mov dx, 160*13
    call switch 

    ;backspace
    mov ah, 1
    mov al, 0
    call switch        

    ;print empty top = 0
    mov ah, 2
    mov al, 0
    mov dx, 160*14
    call switch   

    ;backspace 
    mov ah, 1
    mov al, 0
    call switch

    ;input C
    mov ah, 0
    mov al, 43H
    call switch       

    ;print C
    mov ah, 2
    mov al, 0
    mov dx, 160*15
    call switch               


    mov ax, 4c00H
    int 21H    

switch:
    jmp switch_start
    table dw push_char, back_space, print_seq
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
    push si
    mov si, top
    mov byte ptr ds:[si], al
    inc top
    pop si 
    ret

back_space:
    cmp top, 0
    je back_space_ret
    dec top
back_space_ret:
    ret

print_seq:
    push ax
    push bx
    push cx
    push es
    push si
    push di

    cmp top, 0
    je print_seq_ret    

    mov si, 0
    mov cx, top

    mov bx, 0B800H
    mov es, bx

    loop_print:
        mov al, byte ptr ds:[si] 
        mov di, si
        add di, di
        add di, dx
        mov byte ptr es:[di], al
        inc si
    loop loop_print

print_seq_ret:
    pop di
    pop si
    pop es
    pop cx
    pop bx
    pop ax
    ret
switch_ret:
    pop bx
    ret


code ends

end start