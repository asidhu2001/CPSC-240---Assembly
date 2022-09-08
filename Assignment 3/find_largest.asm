
section .data

;System Calls
SYS_WRITE 		equ 		1
SYS_EXIT		equ		60


;Exit Codes
EXIT_SUCCESS		equ		0


;File Descriptors
FD_STDIN		equ		0
FD_STDOUT		equ		1


;newline call
CRLF			db		13,10
CRLF_LEN		equ		$-CRLF

MY_INTS		equ		100
		

section .text
extern libPuhfessorP_printSignedInteger64

global find_largest
find_largest:

	push rbp
	push rbx
	push r12
	push r13
	push r14
	push r15
	
	
initializeLoop:

	
	mov r13, 0 			;index of initial max to 0
	
	mov r11, [r12 + (r13 * 8)]	;give r11 the best (max) value at index 0 in r13
					;r12 is pointer to first index
					
	mov rbx, 1			;start index for loop
	mov r10, [r12 + (rbx * 8)]	;give r9 the value of the current index
	
loopFindMax:

	cmp rbx, r14			;while the index 1 is less than or equal to the size, jump to checkMax
	jle checkMax
	jmp end
	
checkMax:
	
	cmp r10, r11			;compare values at indexes
	jg saveMax			;if the value in r9 is greater than the max, jump to saveMax
	
	mov rax, r13			;save index of max value when only inputting 1 int
	
	inc rbx
	
	cmp rbx, r14
	jge end
	
	mov r10, [r12 + (rbx * 8)]	;update value of r9
	
	jmp loopFindMax
	
	
saveMax:
	
	mov r13, rbx
	mov rax, rbx
				;save index of max value
	
	mov r11, r10			;give r11 new max			
	
	inc rbx
	mov r10, [r12 + (rbx * 8)]	;update value of r9	
	
	cmp rbx, r14
	jge end
	
	jmp loopFindMax
	
	
end:	
	
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	
	ret
	
	
	
	
	
	
	
	
