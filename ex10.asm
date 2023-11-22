assume cs:code, ss:stack

stack segment
   db 8 dup (255) 
stack ends

code segment
    ; s: mov ax, bx
    ;    mov ax, 0
 
start: 
    ; mov si, offset s
    ; mov di, offset s0
    ; mov ax,         cs:[si]
    ; mov cs:[di],    ax
s:  mov ax, bx
    mov ax, 0


s0: nop
    nop



mov ax, 4c00H
int 21H    

code ends

end start
 