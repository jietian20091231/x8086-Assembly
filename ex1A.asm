assume cs:code, ss:stack, ds:data
stack segment
    dd 16 dup (0)
stack ends

data segment
    ;dw 0A452H, 0A8F5H, 0, 0, 0, 0, 0, 0
    ;dw 0E71EH, 0EF04H, 0, 0, 0, 0, 0, 0
    dw 0FFFFH, 0FFFFH, 0, 0, 0, 0, 0, 0
    dw 0001H, 0000H, 0, 0, 0, 0, 0, 0    
data ends

code segment 
start:
    mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax
    mov sp, 10H    
    call add128
    jmp  ok

add128:
    push ax
    push si
    push di
    push cx        
    mov cx, 8
    mov si, 0
    mov di, 10H
    sub ax, ax    
s:  mov ax, [si]
    adc ax, [di]
    mov [si], ax
    inc si
    inc si
    inc di
    inc di
    loop s
    pop cx
    pop di
    pop si
    pop ax
    ret

ok: mov  ax, 4c00H
    int 21h 

code ends

end start