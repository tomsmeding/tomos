print_number: ;output number in bl to screen, clobbers ax, bl
	xor ax,ax
	mov al,bl
	mov bl,10
	div bl
	;al=input/10 ah=input%10
	mov [.data+2],ah
	xor ah,ah
	div bl
	mov [.data+1],ah
	;al=input/100 ah=input%100
	mov [.data],al
	mov ah,0eh
	cmp byte [.data],0
	jz .print_second_digit_with_check
.print_first_digit:
	;[.data] is still in al
	add al,30h
	int 10h
	mov byte [.data],0
	jmp short .print_second_digit
.print_second_digit_with_check:
	mov al,[.data+1]
	cmp al,0
	jz .print_third_digit
.print_second_digit:
	mov al,[.data+1]
	add al,30h
	int 10h
	mov byte [.data+1],0
.print_third_digit:
	mov al,[.data+2]
	add al,30h
	int 10h
	mov byte [.data+2],0
	ret

.data:
	db 0,0,0
