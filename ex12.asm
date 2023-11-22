assume cs:code, ss:stack

stack segment
   db 8 dup (255) 
stack ends

code segment 
start: 
    mov ax, 0
    jmp short s
    add ax, 1
    nop
    nop
s:  inc ax

mov ax, 4c00H
int 21H    

code ends

end start
 