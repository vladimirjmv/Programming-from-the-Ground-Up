.section .data
	text:
		.ascii "edx: %d \n dx: %d \n\0"

.section .text
.globl _start
_start:

movl $1, %edx


movl $1, %eax 
movl $0, %ebx
int $0x80







