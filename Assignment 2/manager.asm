

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
introMSG		db		"This program will reverse your array of integers."
introMSG_LEN		equ		$-introMSG


promptMSG		db		"Enter a sequence of long integers separated by the enter key (one integer per line). Enter 'q' to quit."
promptMSG_LEN		equ		$-promptMSG


enterMSG		db		"Enter the next integer: "
enterMSG_LEN		equ		$-enterMSG


enterAcceptMSG		db		"You entered: "
enterAcceptMSG_LEN	equ		$-enterAcceptMSG


exitMSG		db		"You entered nonsense. Assuming you are done!"
exitMSG_LEN	equ			$-exitMSG


afterLoopMSG		db		"These numbers were received and placed into the array: "
afterLoopMSG_LEN	equ		$-afterLoopMSG


reverseMSG		db		"After the reverse function, these are the numbers of the array in their new order:"
reverseMSG_LEN		equ		$-reverseMSG


afterReverseMSG_pt1		db		"You entered "
afterReverseMSG_pt1_LEN	equ	$-afterReverseMSG_pt1


afterReverseMSG_pt2		db		" total numbers and their mean is "
afterReverseMSG_pt2_LEN	equ	$-afterReverseMSG_pt2


period			db		"."
period_LEN		equ		$-period


returnMSG		db		"The mean will now be returned to the main function."
returnMSG_LEN		equ		$-returnMSG


;newline call
CRLF			db		13,10
CRLF_LEN		equ		$-CRLF


LOCAL_VARIABLE_COUNT	equ		100



section .bss


section .text

extern libPuhfessorP_printSignedInteger64
extern libPuhfessorP_inputSignedInteger64
extern display_array
extern reverse


global manager
manager:
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, introMSG
	mov rdx, introMSG_LEN
	syscall
	
	call crlf
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, promptMSG
	mov rdx, promptMSG_LEN
	syscall
	
	call crlf
	
	push rbp
	push rbx
	push r12
	push r13
	push r14
	push r15
	
	mov rbp, rsp
	mov r10, LOCAL_VARIABLE_COUNT
	imul r10, 8
	sub rsp, r10
	mov r12, rsp
	
	mov r14, 0
	
	
fill_array:
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, enterMSG
	mov rdx, enterMSG_LEN
	syscall
	
	call libPuhfessorP_inputSignedInteger64
	mov r13, rax
	
	mov r11, 0x8000000000000000
	
	cmp r11, rax 
	je loop_done
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, enterAcceptMSG
	mov rdx, enterAcceptMSG_LEN
	syscall
	
	mov rdi, r13
	call libPuhfessorP_printSignedInteger64
	
	call crlf
	
	cmp r14, LOCAL_VARIABLE_COUNT
	jge loop_done
	
	mov [r12 + (r14 * 8)], r13
	inc r14
	
	jmp fill_array
	
		
loop_done:
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, exitMSG
	mov rdx, exitMSG_LEN
	syscall	
	
	call crlf
	call crlf
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, afterLoopMSG
	mov rdx, afterLoopMSG_LEN
	syscall	
	
	call crlf

printLoop:
	mov r15, r12
	lea rbx, [r12 + (r14 * 8) - 1]
	
	mov rdi, r15
	mov rsi, rbx	
	call display_array
	
continueAfterLoop:
	
	call crlf

	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, reverseMSG
	mov rdx, reverseMSG_LEN
	syscall
	
	call crlf
	
	mov rdi, r12
	mov rsi, r14
	call reverse
	
	
	mov rdi, r15
	mov rsi, rbx
	call display_array

	
	call crlf
	
	mov r10, 0

addAll:
	
	cmp r15, rbx
	jg divide
	
	add r10, [r15]
	add r15, 8
	jmp addAll
	
divide:

	cmp r14, 0
	je invalidInput

	mov rax, r10
	cqo
	mov r11, r14
	idiv rax, r11
	
	mov r13, rax
	
	
afterReverse:
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, afterReverseMSG_pt1
	mov rdx, afterReverseMSG_pt1_LEN
	syscall
	
	mov rdi, r14
	call libPuhfessorP_printSignedInteger64
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, afterReverseMSG_pt2
	mov rdx, afterReverseMSG_pt2_LEN
	syscall
	
	
	mov rdi, r13
	call libPuhfessorP_printSignedInteger64

	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, period
	mov rdx, period_LEN
	syscall
	
	call crlf
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, returnMSG
	mov rdx, returnMSG_LEN
	syscall
	
	jmp finalValue
	
	
invalidInput:

	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, afterReverseMSG_pt1
	mov rdx, afterReverseMSG_pt1_LEN
	syscall
	
	mov rdi, r14
	call libPuhfessorP_printSignedInteger64
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, afterReverseMSG_pt2
	mov rdx, afterReverseMSG_pt2_LEN
	syscall
	
	mov rdi, r14
	call libPuhfessorP_printSignedInteger64

	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, period
	mov rdx, period_LEN
	syscall
	
	call crlf
	
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, returnMSG
	mov rdx, returnMSG_LEN
	syscall
	
	mov rax, r14
	jmp end
	
		
finalValue:

	mov rax, r13	
	
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
	
	
