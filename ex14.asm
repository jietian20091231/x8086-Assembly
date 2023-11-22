assume cs:code, ss:stack, ds:data

stack segment
   db 8 dup (0) 
stack ends


data segment
    db 8 dup (0)
data ends


code segment 
s0:  add ax, 1
     inc ax
     jmp s

start:
    mov ax, data
    mov ds, ax   
    mov ax, offset s0
    mov ds:[0], ax
    jmp word ptr ds:[0]
s:  mov ax, 4c00H
    int 21H    

code ends

end start
 