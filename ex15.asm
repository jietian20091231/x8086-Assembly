assume cs:code, ss:stack, ds:data

stack segment
   db 8 dup (0) 
stack ends


data segment
    dw 0FAH, 0FEH, 0000H, 0023H
data ends

code segment 
start:
    mov ax, data
    mov ds, ax
    mov cx, 4
    
    mov si, 0
s:  mov cx, ds:[si]
    mov dx, cx
    add si, 2
    jcxz ok 
    loop s

ok: mov ax, 4c00H
    int 21H 


code ends

end start
 