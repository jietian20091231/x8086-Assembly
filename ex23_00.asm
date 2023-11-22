assume cs:code, ss:stack, ds:data
stack segment
    dd 16 dup (0)
stack ends

data segment
    dw 8 dup (0)
data ends

code segment 

caps:
    push si
    push cx
    mov si, 0
change:
    mov cl, [bx+si]
    mov ch, 0
    jcxz ok
    and byte ptr [bx+si], 11011111b
    inc si
    jmp short change    
ok: 
    pop cx
    pop si
    iret
capsend: nop

start:
    mov ax, stack
    mov ss, ax
    mov ax, data
    mov ds, ax
inst:
    mov ax, cs
    mov ds, ax
    mov si, offset caps
    mov ax, 0
    mov es, ax
    mov di, 200H
    mov cx, offset capsend - offset caps
    cld
    rep movsb

    mov word ptr es:[7CH * 4], 200H   ;IP
    mov word ptr es:[7CH * 4 + 2], 0  ;CS
    
    mov ax, 4c00H
    int 21H

code ends

end start