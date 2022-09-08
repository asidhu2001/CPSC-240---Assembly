
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


divVar			dq		2.0
triangleArea		dq		0.0	

testNumber		dq		0.0
testNumber2		dq		0.0
testNumber3		dq		0.0

section .text
extern libPuhfessorP_printFloat64 

;double(a, b, c)
;internal usage
	;xmm3 side a
	;xmm7 side b
	;xmm8 side c

global compute_area
compute_area:

	push r15
	
	movsd xmm15, [triangleArea]
	
	;movsd xmm0, xmm2
	;call libPuhfessorP_printFloat64
	
	movsd xmm3, xmm0			;practicing enter 1, 2, 3: 1 = 1
	movsd xmm7, xmm1			;2 = 2
	movsd xmm8, xmm2			;3 = 3
	
	;movsd xmm0, xmm3
	;call libPuhfessorP_printFloat64
	;call crlf
	
	;movsd xmm0, xmm7
	;call libPuhfessorP_printFloat64
	;call crlf	
	
	;movsd xmm0, xmm8
	;call libPuhfessorP_printFloat64
	;call crlf
	
	addsd xmm0, xmm1			;1 + 2 = 3
	movsd qword [testNumber], xmm0 
	
	;movsd xmm0, [testNumber]
	;call libPuhfessorP_printFloat64 	;should print 3
	;call crlf
	
	;movsd xmm0, xmm2
	;call libPuhfessorP_printFloat64
	;call crlf
	
	
	addsd xmm2, [testNumber]		;3 + 3 = 6
	movsd qword [testNumber2], xmm2
	
	;movsd xmm0, xmm2
	;call libPuhfessorP_printFloat64	;prints 6
	
	nop
	divsd xmm2, qword [divVar] 		;6/2 = 3
	nop
	
	movsd xmm4, xmm2	
	movsd xmm5, xmm2	;make all equal to 3
	movsd xmm6, xmm2
	movsd xmm10, xmm2
	
	subsd xmm4, xmm3	;3 - 1 = 2	
	subsd xmm5, xmm7	;3 - 2 = 1
	subsd xmm6, xmm8	;3 - 3 = 0 
	
	mulsd xmm10, xmm4	;3*2 = 6
	mulsd xmm10, xmm5	;6*1 = 6
	mulsd xmm10, xmm6	;6*0 = 0
	
	movsd qword [testNumber3], xmm10
	
	ucomisd xmm10, xmm15
	jb endInvalid;
	
	sqrtsd xmm0, qword [testNumber3]     ;sqrt0 = 0
	movsd qword [triangleArea], xmm0
	
	jmp end
	
endInvalid:
	
	movsd xmm0, xmm15
	movsd qword [triangleArea], xmm0

end:
	pop r15
	
	ret
	

	
crlf:
	
	mov rax, SYS_WRITE			
	mov rdi, FD_STDOUT			
	mov rsi, CRLF				
	mov rdx, CRLF_LEN			
	syscall
	
	ret
	
	
	
	
	
	
	
	
