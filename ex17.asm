assume cs:code, ss:stack, ds:data

data segment
    dd 16 dup (0)
data ends

stack segment
    dw 16 dup (0)
stack ends

code segment 

difcube:
    push bp                 ; store bp
    mov  bp, sp             ; (bp) = sp
    mov  ax, ss:[bp + 4]    ; ((ss) * 16 + (bp + 4)) = 3
    sub  ax, ss:[bp + 6]    ; ((ss) * 16 + (bp + 4)) - ((ss) * 16 + (bp + 6))  = 3 - 1 = 2
    mov  bp, ax
    mul  bp
    mul  bp
    pop  bp                ; recover bp
    ret  4

main:
    mov ax, data
    mov ds, ax    
    mov ax, stack
    mov ss, ax
    mov sp , 10H

    mov ax,  1
    push ax
    mov ax, 3
    push ax

    call difcube
    mov word ptr ds:[2], dx
    mov word ptr ds:[0], ax    
    mov  ax, 4c00H
    int 21h    


code ends

end main