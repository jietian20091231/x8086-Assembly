assume cs:code, ss:stack, ds:data

data segment
    dd 16 dup (0)
data ends

stack segment
    dd 16 dup (0)
stack ends

code segment 
ok: mov dx, bx
    mov ax, 4c00H
    int 21h

add_s: add ax, 1
       ret    
start:
    mov ax, data
    mov ds, ax    
    mov ax, stack
    mov ss, ax
    mov sp , 10H
    mov ax, offset ok               ;cs
    mov word ptr ds:[2], cs         ;IP    
    mov ds:[0], ax    

; s:  mov cx, [bx]
;     jcxz ok 
;     inc bx
;     inc bx
;     jmp short s    

call far ptr add_s
call dword ptr ds:[0]


code ends

end start