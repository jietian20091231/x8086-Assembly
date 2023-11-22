assume cs:code, ss:stack, ds:data
stack segment
    dd 16 dup (0)
stack ends

data segment
    db 8, 11, 8, 9, 8, 5, 63, 38
    dw 0,  0,  0
data ends

code segment 
start:
    mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax
    mov sp, 10H 
    mov cx, 8   
    call compare
    jmp  ok


compare: 
    push ax
    push dx
    push si
    push di
    push cx
    mov ax, 0
    mov si, 0
    mov cx, 8
    mov di, 8
    mov dl, 8
s:  
    mov al, byte ptr[si]
    cmp al, dl
    je s0      ; a == b
c1: cmp dl, al
    jl s2 
c2: cmp al, dl
    jl s1
    jmp short ext   


s0:
    mov ax, ds:[di + 2]
    inc ax
    mov ds:[di + 2], ax
    jmp short next    

s1:
  mov ax, ds:[di]
  inc ax
  mov ds:[di], ax
  jmp short next

s2:
  mov ax, ds:[di+4]
  inc ax
  mov ds:[di+4], ax
  jmp short next 

next: 
    inc si
    loop s    

ext:
    pop cx
    pop di
    pop si
    pop dx
    pop ax
    
      
ok: mov  ax, 4c00H
    int 21h 

code ends

end start