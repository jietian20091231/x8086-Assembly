assume cs:code, ss:stack, ds:data
stack segment
    db 16 dup (255)
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
    mov sp, 16

    ; mov dh, 12
    ; mov dl, 20
    ; mov si, 0
    ; call recv_char_str
    mov ax, 4C00H
    int 21H

recv_char_str:
    push ax
recv_char_listen:
    ; mov ah, 0
    ; int 20H

    mov al, 41H
    mov ah, 1EH

    cmp al, 20H
    jb no_display_char
    ;; push char
    mov ah, 0
    call char_stack_op
    ;; display char_stack 
    mov ah, 2
    call char_stack_op

    ;jmp recv_char_listen ;; loop listening

no_display_char:
    cmp ah, 0EH
    je backspace
    cmp ah, 1CH
    je enter
    jmp recv_char_listen

backspace:
    ;; pop char 
    mov ah, 1
    call char_stack_op
    ;; display char_stack 
    mov ah, 2
    call char_stack_op

enter:
    mov al, 0
    ;; push 0 to char_stack
    mov ah, 0
    call char_stack_op
    ;; display char_stack 
    mov ah, 2
    call char_stack_op

recv_char_str_ret:
    pop ax
    ret


char_stack_op:
    jmp char_stack_op_start
    table dw push_char, pop_char, show_chars
    top dw 0

char_stack_op_start:
    ;; push all used register to stack    
    push bx
    push dx
    push es    
    push di


    cmp ah, 2
    ja char_stack_op_ret
    mov bl, ah
    mov bh, 0
    add bx, bx
    call word ptr table[bx]

push_char:
    mov bx, top
    mov [si][bx], al
    inc top
    jmp char_stack_op_ret 

pop_char:
    cmp top, 0
    je char_stack_op_ret
    dec top
    mov bx, top
    mov al, [si][bx]
    jmp char_stack_op_ret

show_chars:
    mov bx, 0B800H
    mov es, bx
    mov al, 160
    mov ah, 0
    mul dh
    mov di, ax
    add dl, dl
    mov dh, 0
    add di, dx

    mov bx, 0

show_chars_0:
    cmp bx, top
    jne no_empty
    mov byte ptr es:[di], ' '
    jmp char_stack_op_ret

no_empty:
    mov al, [si][bx]
    mov es:[di],al
    mov byte ptr es:[di+2], ' '
    inc bx
    add di, 2
    jmp show_chars_0
    
char_stack_op_ret:
    ;;pop all used register to stack
    pop di
    pop es
    pop dx
    pop bx
    ret                 ; 0774:0000

code ends

end start