assume cs:code, ds:data, ss:stack

stack segment
    dw 0,0,0,0,0,0,0,0,0
stack ends

data segment
        dd 0F0F0F0F0H       ;32
        dw 0FFFFH             ;16
        dw 0                ;16
data ends

code segment
start: 
    mov ax, data
    mov ds, ax
    mov ax, ds:[0]
    mov dx, ds:[2]
    div word ptr ds:[4]
    mov ds:[6], ax


mov ax, 4c00H
int 21H    

code ends

end start
 