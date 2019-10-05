.section .data
	args:
		.ascii "String: %s \n"
	text:
		.ascii "string je bez nullTerminated"

.equ LINUX_SYSCALL, 0x80
.equ SYS_EXIT, 1

.section .text
.global _start
_start:

movl $5, %eax
pushl $text
pushl $args
call printf

addl $8, %esp

movl $SYS_EXIT, %eax
movl $0, %ebx
int $LINUX_SYSCALL
