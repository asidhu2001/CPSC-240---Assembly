
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


welcomeMSG		db		"The manager is here to assist you."
welcomeMSG_LEN		equ		$-welcomeMSG


receivedMSG1		db		"Total numbers entered: "
receivedMSG1_LEN	equ		$-receivedMSG1


receivedMSG2		db		"The largest value "
receivedMSG2_LEN	equ		$-receivedMSG2


receivedMSG3		db		" has been found at index "
receivedMSG3_LEN	equ		$-receivedMSG3


passonMSG		db		"The manager will now return the count to the driver."
passonMSG_LEN		equ		$-passonMSG


invalidMSG		db		"You entered nonsense! Assuming you are done."
invalidMSG_LEN		equ		$-invalidMSG


MY_INTS		equ		100

section .bss



section .text
extern input_array
extern output_array
extern find_largest
extern libPuhfessorP_printSignedInteger64
extern libPuhfessorP_inputSignedInteger64



;Register usage
;	r12: Pointer to the beginning of our array
;	r13: Current number to write
;	r14: Current index/max number of ints
;	r15: Running pointer
;	rbx: Stopping point for the running pointer (pointer to the last integer)


global manager
manager:

	push rbp
	push rbx
	push r12
	push r13
	push r14
	push r15
	
	mov rbp, rsp
	
	mov r10, MY_INTS
	imul r10, 8
	sub rsp, r10
	
	mov r12, rsp
	mov r14, MY_INTS
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, welcomeMSG
	mov rdx, welcomeMSG_LEN
	syscall
	
	call crlf
	call crlf
	
	mov rdi, r12
	mov rsi, r14
	call input_array
	
	mov r14, rax
	mov r11, 0
	cmp r14, r11
	je invalidInput
	
afterInit:
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, receivedMSG1
	mov rdx, receivedMSG1_LEN
	syscall
	
	mov rdi, r14
	call libPuhfessorP_printSignedInteger64
	
	call crlf
	call crlf
	
outPut:
	
	mov r15, r12
	lea rbx, [r12 + (r14 * 8) - 1]
	
	mov rdi, r15
	mov rsi, rbx	
	call output_array
	
	
largest:

	mov r13, r14

	mov rdi, r12
	mov rsi, r14
	call find_largest
	
	mov r14, rax
	
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, receivedMSG2
	mov rdx, receivedMSG2_LEN
	syscall
	
	mov rdi, [r12 + (r14 * 8)]
	call libPuhfessorP_printSignedInteger64
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, receivedMSG3
	mov rdx, receivedMSG3_LEN
	syscall
	
	mov rdi, r14
	call libPuhfessorP_printSignedInteger64
	
	call crlf
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, passonMSG
	mov rdx, passonMSG_LEN
	syscall
	
	mov rax, r13
	jmp end
	
invalidInput:
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, passonMSG
	mov rdx, passonMSG_LEN
	syscall

	mov rax, 0
	
end:	
	
	mov rsp, rbp
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
	


	
	
	

