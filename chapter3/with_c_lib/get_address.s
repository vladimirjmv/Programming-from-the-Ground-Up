.section .data
 	data_items: #These are the data items
		.long 3,67,34,222,45,75,54,34,44,33,22,11,66,0

	text:
		.ascii "value: %x \n \0"
.section .text
.globl _start
_start:

movl _start, %eax
#pushl $text
#call printf


movl $1, %eax 					#1 is the exit() syscall
int $0x80
