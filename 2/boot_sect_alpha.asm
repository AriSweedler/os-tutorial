	mov ah, 0x0e ; tty mode
	mov al, 'A' ; init al to 'A'.

start:
	int 0x10 ; print
	cmp al, 'Z' ; if we just printed 'Z' then finish
	je done
	inc al ; otherwise increment and jump to start
	jmp start

done:
	jmp $ ; jump to current address = infinite loop

; padding and magic number
times 510 - ($-$$) db 0
dw 0xaa55 
