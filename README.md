# x8086-Assembly
----------
I'm come from Github

x8086-Assembly

ex27.asm 的bugs说明

```
diff --git a/ex27.asm b/ex27.asm
index 9b88100..c042e43 100644
--- a/ex27.asm
+++ b/ex27.asm
@@ -29,21 +29,21 @@ start:
     mov es, ax
     mov ah, 'a'
  s:
-    mov es:[160 * 12 + 40 * 2 + 2], ah          ;显示位置计算错误
+    mov es:[160 * 12 + 40 * 2], ah    
     call delay
     inc ah
     cmp ah, 'z'
     jna s
 
     ; restore code 9 interrput program entry address
-    ; mov ax, 0                             ; 没有回复被修改的9号中断例程
-    ; mov es, ax
-    ; push ds:[0]
-    ; pop ax
-    ; mov word ptr es:[9 * 4], ax
-    ; push ds:[1]                          ; 内存中的地址计算错误，导致程序无法退出，dw是双字，应该是2
-    ; pop ax
-    ; mov word ptr es:[9 * 4 + 2], ax
+    mov ax, 0                            
+    mov es, ax
+    push ds:[0]
+    pop ax
+    mov word ptr es:[9 * 4], ax
+    push ds:[2]
+    pop ax
+    mov word ptr es:[9 * 4 + 2], ax
 
     mov ax, 4C00H
     int 21H
@@ -62,18 +62,19 @@ s1:
     jne s1
     pop dx
     pop ax
-    ret    
+    ret  
 
-    ; diy define code 9 interrput program
+; diy define code 9 interrput program
 int_9:
     push ax
+    push bx                                    ;复用寄存器ax, 接收的键盘中断的al值被覆盖，导致功能无响应
     push es
     in al, 60H
     pushf
     pushf
-    pop ax
-    and ah, 11111100B
-    push ax
+    pop bx
+    and bh, 11111100B
+    push bx
     popf
     call dword ptr ds:[0]                      ; push与pop寄存器一定要成对出现，应该注意出入栈操作的次序
```
