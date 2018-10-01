;
; A simple boot sector program that demonstrates addressing.
;
the_secret:
  db 'X'
  db 'Y'

  mov ah, 0x0e ; int 10/ah = 0eh -> scrolling teletype BIOS routine

; First attempt
; this fails because we're moving an address into the register.
  ;mov al, the_secret

; Second attempt
; this fails because the boot sector is loaded into address 0x7C00, and we
; dereferenced an offset from 0, not an offset from where we're loaded.
	;mov al, [the_secret]

; Althought, if we defined a "global offset" for every memory location, with the
; org command, then this would work. Of course, this would break the third
; attempt's successful solution (but not the fourth's)
	; [org 0x7c00]

; Third attempt
; this works, because we're now dereferencing the right address
	mov al, [the_secret + 0x7C00]
  int 0x10

; Fourth attemp
; This works (at printing 'Y'!) because we're just hard-coding the label's
; address. If the label moved, we'd have to re-calculate this.
	mov al, [0x1 + 0x7C00]
  int 0x10
	
; Infinite loop (e9 fd ff)
loop:
  jmp loop 

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0
; Magic number
dw 0xaa55
