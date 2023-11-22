assume cs:code, ss:stack

stack segment
   db 8 dup (255) 
stack ends

code segment 
start: jmp short s
    db 128 dup (0)
s:  mov ax, 0FFFFH
mov ax, 4c00H
int 21H    

code ends

end start
 