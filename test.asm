assume cs:code,ss:stack
stack segment
	db 128 dup(0)
stack ends
code segment
;初始化寄存器
start:	mov ax,stack
		mov ss,ax
		mov sp,128
		push cs
		pop ds
		mov si,offset intN9
		mov ax,0
		mov es,ax
		mov di,204
;保存原来int9号的入口地址到0:200地址
		push es:[9*4+2]
		pop es:[202]
		push es:[9*4]
		pop es:[200]
;复制新中断程序到0:204地址
		mov cx,offset intEnd9 - offset intN9
		cld
		rep movsb
;修改中断向量表中原来的入口地址为新的入口地址
		cli
		mov word ptr es:[9*4],204
		mov word ptr es:[9*4+2],0
		sti

		mov ax,4c00h
		int 21h
;新int9号程序,保留原有int9号功能，增加按ESC键改变屏幕颜色
intN9:	
		push ax
		push es
		push bx
		push cx
		pushf
		pushf
		pop ax
		and ah,11111100b
		push ax
		popf
		call dword ptr cs:[200]
		;判断是否是ESC键，是就修改颜色，否则保持原来键的功能
		in al,60h
		cmp al,1;ESC键的扫描码：1
		jne intS9
		mov ax,0B800h
		mov es,ax
		mov bx,1
		mov cx,2000	
	s:	inc byte ptr es:[bx]
		add bx,2
		loop s
		
intS9:	pop cx
		pop bx
		pop es
		pop ax
		iret
intEnd9: nop

code ends
end start
		

