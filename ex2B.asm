assume cs:code, ss:stack, ds:data
stack segment
    db 32 dup (255)
stack ends

data segment
    db 32 dup (0)
data ends

code segment
stack_opt:
    jmp stack_opt_start
    table dw push_char, back_space, print_seq
    top dw 0
stack_opt_start:
    push bx

    cmp ah, 2
    ja stack_opt_ret
    mov bl, ah
    mov bh, 0
    add bx, bx
    call word ptr table[bx]   

    jmp stack_opt_ret

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

stack_opt_ret:
    pop bx
    ret


input_func:
    push ax
    read_char:
        mov ah, 0
        int 16H

        cmp al, 20H
        jb no_char
        mov ah, 0
        call stack_opt
        mov ah, 2
        call stack_opt
        jmp read_char        


enter_proc:
    mov ah, 2
    call stack_opt
    jmp input_func_ret

backspace_proc:

    mov ah, 1
    call stack_opt

    push es
    push bx
    push di 

    mov bx, 0B800H
    mov es, bx
    mov di, top
    add di, di
    add di, dx
    mov byte ptr es:[di], 0
    pop di
    pop bx
    pop es
    jmp read_char

no_char:
    cmp ah, 0EH
    je backspace_proc
    cmp ah, 1CH
    je enter_proc

input_func_ret:
    pop ax
    ret

start:
    mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax
    mov sp, 32

    mov dx, 160*13

    call input_func

    mov ax, 4c00H
    int 21H      

code ends

end start