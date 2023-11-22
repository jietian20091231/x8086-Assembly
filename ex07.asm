assume cs:code, ds:data, ss:stack

stack segment
        dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
stack ends

data segment
        dw 0123H, 0456H, 0789H, 0ABCH, 0DEFH, 0FEDH, 0CBAH, 0987H
data ends

code segment
start: 
        mov ax, stack
        mov ss, ax
        mov sp, 20H
        mov ax, data
        mov ds, ax

        mov bx, 0
        mov cx, 8

     s: push [bx]   
        add bx, 2
        loop s
     
        mov bx, 0
        mov cx, 8

    s0: pop [bx]
        add bx, 2
        loop s0

mov ax, 4c00H
int 21H    

code ends

end start
