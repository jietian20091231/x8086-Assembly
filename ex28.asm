assume cs:code, ss:stack
stack segment
    db 128 dup (0)
stack ends

code segment 
start: 
    mov ax, stack
    mov ss, ax
    mov sp, 128
    push cs
    pop  ds
    mov ax, 0
    mov es, ax

    ;; install  new int9 interrupt function
    mov si, offset int_9
    mov di, 204H
    mov cx, offset int_9_end - offset int_9
    cld
    rep movsb


    ;; change orginal int9 function address to 0200H
    push es:[9 * 4]
    pop es:[200H]
    push es:[9 * 4 + 2]
    pop es:[202H]

    ;; copy new int9 interrupt function address to 204H
    cli
    mov word ptr es:[9 * 4], 204H
    mov word ptr es:[9 * 4 + 2], 0
    sti


    mov ax, 4C00H
    int 21H

;; new int9 interrput function
int_9:
    push ax 
    push bx
    push cx
    push es

    in al, 60H

    pushf
    call dword ptr cs:[200H]

    cmp al, 3BH
    jne int_9_ret
    mov ax, 0B800H
    mov es, ax
    mov bx, 1
    mov cx, 2000
s:
    inc byte ptr es:[bx]
    inc bx
    inc bx
    loop s
int_9_ret:
    pop es
    pop cx
    pop bx
    pop ax
    iret
int_9_end:
    nop

code ends

end start