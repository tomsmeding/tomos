	BITS 16

start:
%include "bootloader_setup.asm"

	mov ax, 0x0002 ;ah=00 (set video mode), al=02 (80x25 16 shades of gray text)
	int 10h ;clear screen

	mov si, intro_string	; Put string position into SI
	call print_string		; Call our string-printing routine

;%assign i 90
;%rep 20
;	mov bl,i
;	call print_number
;	mov ax,0e20h
;	int 10h
;%assign i i+1
;%endrep

key_print_loop:
	mov ah, 0h
	int 16h
	; ah = scancode
	; al = ascii or zero if func key
	mov ah,0eh
	int 10h
	mov bl,al
	mov al,' '
	int 10h
	call print_number
	mov ax,0e0dh ;ah=0eh=print, al=0d=CR
	int 10h ;print CR
	mov al,0ah ;0a=LF
	int 10h ;print LF
	jmp key_print_loop

	jmp $					; Jump here - infinite loop!


	intro_string db "TomOS started, version 0.1-dev", 13, 10, 0

%include "print_string.asm"
%include "print_number.asm"

%include "bootloader_endfile.asm"
