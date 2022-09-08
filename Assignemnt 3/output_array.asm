
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


initialMSG		db		"The following inetgers were recieved:"
initialMSG_LEN		equ		$-initialMSG


firstParanthesesMSG		db		"( "
firstParanthesesMSG_LEN	equ	$-firstParanthesesMSG


intMSG			db		" integers ) "
intMSG_LEN		equ		$-intMSG


MY_INTS		equ		100



commaMSG		db		", "
commaMSG_LEN		equ		$-commaMSG


section .text
extern libPuhfessorP_printSignedInteger64

global output_array	
output_array:

	push rbp
	push rbx
	push r12
	push r13
	push r14
	push r15
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, initialMSG
	mov rdx, initialMSG_LEN
	syscall
	
	call crlf
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, firstParanthesesMSG
	mov rdx, firstParanthesesMSG_LEN
	syscall
	
	mov rdi, r14
	call libPuhfessorP_printSignedInteger64
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, intMSG
	mov rdx, intMSG_LEN
	syscall
	
	
printLoop_top
	
	cmp r15, rbx
	jg printLoop_done
	
print:	

	mov rdi, [r15]
	call libPuhfessorP_printSignedInteger64	
	
	add r15, 8
	cmp r15, rbx
	jge printLoop_done
	
comma:	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, commaMSG
	mov rdx, commaMSG_LEN
	syscall
		
	jmp printLoop_top
	

printLoop_done:


	call crlf
	
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	
	ret
	
crlf:
	
	mov rax, SYS_WRITE			
	mov rdi, FD_STDOUT			
	mov rsi, CRLF				
	mov rdx, CRLF_LEN			
	syscall
	
	ret	
	

