
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


promptMSG		db		"The manager is here to help you find the area of your triangle."
promptMSG_LEN		equ		$-promptMSG	


invalidMSG		db		"Your triangle is nonsense!"
invalidMSG_LEN		equ		$-invalidMSG


finalMSG		db		"The area will be returned to Heron."
finalMSG_LEN		equ		$-finalMSG



;global variables
triangleSide1		dq		0.0
triangleSide2		dq		0.0
triangleSide3		dq		0.0
triangleArea		dq		0.0
dummyTriangle		dq		0.0

dummySide1		dq		180213193408853.2		;dummy numbers for input validation hoping the user would never enter these specfifc numbers in a row
dummySide2		dq		9099231233.2313		;however if entered, the program will not run as intended due to it being the only case that would not work
dummySide3		dq		213213123.32183439		;due to how the input validation was implemented



section .text
extern get_sides
extern compute_area
extern show_results
extern libPuhfessorP_printFloat64


global triangle
triangle:
	
	push r15
	
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, promptMSG
	mov rdx, promptMSG_LEN
	syscall
	
	call crlf
	
	movsd xmm12, qword [dummySide1]
	movsd xmm13, qword [dummySide2]
	movsd xmm14, qword [dummySide3]
	
	mov rdi, triangleSide1
	mov rsi, triangleSide2
	mov rdx, triangleSide3
	call get_sides
	
	ucomisd xmm12, [triangleSide1]
	je end
	
	ucomisd xmm13, [triangleSide2]
	je end
	
	ucomisd xmm14, [triangleSide3]
	je end
	
	call crlf

	
	movsd xmm0, [triangleSide1]
	movsd xmm1, [triangleSide2]
	movsd xmm2, [triangleSide3]
	call compute_area
	
	ucomisd xmm0, qword [dummyTriangle]
	jbe invalidMessage
	
	jmp contNormal
	
invalidMessage:
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, invalidMSG
	mov rdx, invalidMSG_LEN
	syscall
	
	call crlf
	
	movsd qword [triangleArea], xmm0
	
	movsd xmm0, [triangleSide1]
	movsd xmm1, [triangleSide2]
	movsd xmm2, [triangleSide3]
	movsd xmm3, qword [triangleArea]
	call show_results
	
	jmp end
	
contNormal:		

	
	movsd qword [triangleArea], xmm0
	
	
	movsd xmm0, [triangleSide1]
	movsd xmm1, [triangleSide2]
	movsd xmm2, [triangleSide3]
	movsd xmm3, qword [triangleArea]
	call show_results
	
end:
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, finalMSG
	mov rdx, finalMSG_LEN
	syscall
	
	call crlf
	
	pop r15
	
	movsd xmm0, qword [triangleArea]
	ret
	


crlf:
	
	mov rax, SYS_WRITE			
	mov rdi, FD_STDOUT			
	mov rsi, CRLF				
	mov rdx, CRLF_LEN			
	syscall
	
	ret
	
