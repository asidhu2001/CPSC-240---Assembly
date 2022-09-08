
section .data

;System Calls
SYS_WRITE 		equ 		1
SYS_EXIT		equ		60




;Exit Codes
EXIT_SUCCESS		equ		0




;File Descriptors
FD_STDIN		equ		0
FD_STDOUT		equ		1



;Strings
areaMSG		db		"This area function is fondly brought to you by Amritpaul Sidhu"
areaMSG_LEN		equ 		$-areaMSG



promptMSG		db		"Please enter the radius of a circle in whole number of meters: "
promptMSG_LEN		equ		$-promptMSG



confirmMSG		db		"The number "  
confirmMSG_LEN		equ		$-confirmMSG
confirmMSG2		db		" was recieved."
confirmMSG2_LEN	equ		$-confirmMSG2


resultMSG		db		"The area of a circle with this radius is "
resultMSG_LEN		equ		$-resultMSG


resultMSG2		db		" and "
resultMSG2_LEN		equ		$-resultMSG2


resultMSG3		db		"/7 sqaure meters."
resultMSG3_LEN		equ		$-resultMSG3


goodbyeMSG		db		"The integer part of the area will be returned to the main program. Please enjoy your circles."
goodbyeMSG_LEN		equ		$-goodbyeMSG


;newline call
CRLF			db		13,10
CRLF_LEN		equ		$-CRLF



;inputted integer
inputInt		dq		0


section .bss



section .text


;external symbols
extern scanf
extern libPuhfessorP_printSignedInteger64
extern libPuhfessorP_inputSignedInteger64



global area
area:
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, areaMSG
	mov rdx, areaMSG_LEN
	syscall
	
	call crlf
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, promptMSG
	mov rdx, promptMSG_LEN
	syscall
	
	call libPuhfessorP_inputSignedInteger64
	mov [inputInt], rax
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, confirmMSG
	mov rdx, confirmMSG_LEN
	syscall
	
	mov rdi, [inputInt]
	call libPuhfessorP_printSignedInteger64
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, confirmMSG2
	mov rdx, confirmMSG2_LEN
	syscall
	
	call crlf
	
	mov r12, [inputInt]
	imul r12, r12
	imul r12, 22
	
	mov rax, r12
	cqo
	mov r10, 7
	idiv rax, r10

	mov r13, rax
	mov r14, rdx
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, resultMSG
	mov rdx, resultMSG_LEN
	syscall
	
	mov rdi, r13
	call libPuhfessorP_printSignedInteger64
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, resultMSG2
	mov rdx, resultMSG2_LEN
	syscall
	
	mov rdi, r14
	call libPuhfessorP_printSignedInteger64
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, resultMSG3
	mov rdx, resultMSG3_LEN
	syscall
	
	call crlf
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, goodbyeMSG
	mov rdx, goodbyeMSG_LEN
	syscall
	
	call crlf
	mov rax, r13
	ret
	
	
crlf:
	mov rax, SYS_WRITE			
	mov rdi, FD_STDOUT			
	mov rsi, CRLF				
	mov rdx, CRLF_LEN			
	syscall
	
	ret
	
	

	
