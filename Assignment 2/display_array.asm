
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



LOCAL_VARIABLE_COUNT	equ		100



commaMSG		db		", "
commaMSG_LEN		equ		$-commaMSG


section .text
extern libPuhfessorP_printSignedInteger64

global display_array	
display_array:

	push rbp
	push rbx
	push r12
	push r13
	push r14
	push r15
	
	
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
	

	
