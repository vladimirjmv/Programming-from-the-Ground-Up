.section .data
	string:
		.ascii "counter: %d \n\0"

.global _start
_start:

movl $0, %edi

start_loop:
cmpl $20, %edi
je end_loop

pushl %edi
pushl $string
call printf

incl %edi
jmp start_loop

end_loop:


movl $1, %eax
movl $0, %ebx

int $0x80
