.section .data
	args:
		.ascii "No. of args: %d \n \0"

	first:
		.ascii "First arg: %d \n \0"


.equ SYS_EXIT, 1
.equ SYS_READ, 3
.equ SYS_WRITE, 4
.equ SYS_CLOSE, 6

.equ LINUX_SYSCALL, 0x80

.section .bss

.equ BUFFER_SIZE, 500
.lcomm BUFFER_DATA, BUFFER_SIZE

.section .text

.equ NO_OF_ARGS, 0
.equ FIRST_ARG, 8

.global _start
_start:
movl %esp, %ebp

pushl NO_OF_ARGS(%ebp)
pushl $args
call printf 
addl $8, %esp


movl FIRST_ARG(%ebp), %eax

#movl $0, %esi
#pushl (%eax, %esi, 1)

pushl %eax
pushl $first
call printf


movl $SYS_WRITE, %eax			#get the input file descriptor
movl $1, %ebx					#the location to read into
movl $args, %ecx			#the size of the buffer
movl $21, %edx			#Size of buffer read is returned in %eax
int $LINUX_SYSCALL

movl $SYS_CLOSE, %eax
movl $1, %ebx
int $LINUX_SYSCALL


movl $SYS_EXIT, %eax
movl $0, %ebx
int $LINUX_SYSCALL
