assume cs:code, ss:stack, ds:data
stack segment
    db 128 dup (0)
stack ends

data segment
    dw 0, 0
data ends

code segment 
start: 
    mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax
    mov sp, 128

    ;change code 9 interrput program entry address
    mov ax, 0
    mov es, ax
    push es:[9 * 4]
    pop ds:[0]
    push es:[9 * 4 + 2]
    pop ds:[2]
    mov word ptr es:[9 * 4], offset int_9
    mov es:[9 * 4 + 2], cs

    mov ax, 0B800H
    mov es, ax
    mov ah, 'a'
 s:
    mov es:[160 * 12 + 40 * 2 + 2], ah
    call delay
    inc ah
    cmp ah, 'z'
    jna s

    ; restore code 9 interrput program entry address
    ; mov ax, 0
    ; mov es, ax
    ; push ds:[0]
    ; pop ax
    ; mov word ptr es:[9 * 4], ax
    ; push ds:[1]
    ; pop ax
    ; mov word ptr es:[9 * 4 + 2], ax

    mov ax, 4C00H
    int 21H

delay:
    push ax
    push dx
    mov dx, 10H
    mov ax, 0
s1: 
    sub ax, 1
    sbb dx, 0
    cmp ax, 0
    jne s1
    cmp dx, 0
    jne s1
    pop dx
    pop ax
    ret    

    ; diy define code 9 interrput program
int_9:
    push ax
    push es
    in al, 60H
    pushf
    pushf
    pop ax
    and ah, 11111100B
    push ax
    popf
    call dword ptr ds:[0]

    cmp al, 1
    jne int_9_ret
    mov ax, 0B800H
    mov es, ax
    inc byte ptr es:[160 * 12 + 40 * 2 + 1]

int_9_ret:
    pop es
    pop bx
    pop ax
    iret

code ends

end start