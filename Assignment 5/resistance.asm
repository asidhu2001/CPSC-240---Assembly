
section .data

;System Calls
SYS_WRITE 		equ 		1
SYS_EXIT		equ		60


;Exit Codes
EXIT_SUCCESS		equ		0
earlyExit		equ		0.0


;File Descriptors
FD_STDIN		equ		0
FD_STDOUT		equ		1


;newline call
CRLF			db		13,10
CRLF_LEN		equ		$-CRLF


clockSpeed		dq		0
defaultSpeed		equ		3400

clockTicks		dq		0
clockTicks1		dq		0
clockTicks2		dq		0
nanoseconds		dq		0.0
resistanceVar		dq		0.0

multiplyVar		dq		0.001


foundFreq		db		"Found CPU frequency (MHz): "
foundFreq_LEN		equ		$-foundFreq


unfoundFreq		db		"Unable to find CPU frequency (MHz); Using default value: "
unfoundFreq_LEN	equ		$-unfoundFreq


successInput		db		"Input successfully recieved."
successInput_LEN	equ		$-successInput


failedInput		db		"You entered nonsense! Returning 0.0 to the driver."
failedInput_LEN	equ		$-failedInput

returnMSG		db		"Returning the resistance of the system to the driver."
returnMSG_LEN		equ		$-returnMSG

errorMSG		db		"found but 0"
errorMSG_LEN		equ		$-errorMSG


errorNum		dq		0.0

circuit1		dq		0.0
circuit2		dq		0.0
circuit3		dq		0.0
circuit4		dq		0.0


section .text
extern get_resistance
extern compute_resistance
extern show_resistance
extern libPuhfessorP_printSignedInteger64

global resistance
resistance:

	push r12
	
	call crlf
	mov r10, 0
	mov r11, 0

	mov eax, 0x00
	cpuid
	
	cmp eax, 0x16
	jge foundSpeed
	
	jmp notFound
	
foundSpeed:


	mov eax, 0x16
	cpuid 
	
	mov [clockSpeed], eax
	cvtsi2sd xmm10, qword [clockSpeed]	
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, foundFreq
	mov rdx, foundFreq_LEN
	syscall
	
	mov rdi, [clockSpeed]
	call libPuhfessorP_printSignedInteger64
	
	call crlf
	
	jmp continue
	
	
notFound:


	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, unfoundFreq
	mov rdx, unfoundFreq_LEN
	syscall
	
	mov qword [clockSpeed], defaultSpeed
	
	mov rdi, qword [clockSpeed]
	call libPuhfessorP_printSignedInteger64
	
	call crlf
	
continue:

	
	mov rdi, circuit1
	mov rsi, circuit2
	mov rdx, circuit3
	mov rcx, circuit4
	call get_resistance

	ucomisd xmm0, qword [errorNum]
	je earlyexit
	
	call crlf
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, successInput
	mov rdx, successInput_LEN
	syscall
	
	call crlf

compute:
	
	mov rax, 0
	mov rdx, 0
	rdtsc
	
	shl rdx, 32
	or rax, rdx

	mov r12, rax
	mov [clockTicks1], r12
		
	movsd xmm0, [circuit1]
	movsd xmm1, [circuit2]
	movsd xmm2, [circuit3]
	movsd xmm3, [circuit4]
	call compute_resistance
	
	movsd qword [resistanceVar], xmm0
	
	mov rax, 0
	mov rdx, 0
	rdtsc
	
	shl rdx, 32
	or rax, rdx
	
	sub rax, r12
	mov [clockTicks], rax
	cvtsi2sd xmm2, qword [clockTicks]
	
	
math:

	divsd xmm2, xmm10
	divsd xmm2, [multiplyVar]
	movsd [nanoseconds], xmm2
	
	
show:

	movsd xmm0, qword [resistanceVar]
	movsd xmm1, qword [clockSpeed]
	mov rdi, [clockTicks]
	movsd xmm2, [nanoseconds]
	call show_resistance


exit:
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, returnMSG
	mov rdx, returnMSG_LEN
	syscall
	
	call crlf
	
	pop r12
	
	movsd xmm0, qword [resistanceVar]
	ret
	
	
earlyexit:
	
	call crlf
	
	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, failedInput
	mov rdx, failedInput_LEN
	syscall
	
	pop r12
	
	mov rax, earlyexit
	ret
			
	

crlf:
	
	mov rax, SYS_WRITE			
	mov rdi, FD_STDOUT			
	mov rsi, CRLF				
	mov rdx, CRLF_LEN			
	syscall
	
	ret
	
