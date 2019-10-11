.include "linux.s"
.include "record-def.s"
.section .data
	first_ptr:
		.long 0

	second_ptr:
		.long 0		

	third_ptr:
		.long 0	

	fourth_ptr:
		.long 0

	fifth_ptr:
		.long 0

.section .text
.global _start
_start:

pushl $1236
call allocate
addl $4, %esp
movl %eax, first_ptr

call show_heap

pushl $100
call allocate
addl $4, %esp
movl %eax, first_ptr

call show_heap

/*

pushl $1100
call allocate
addl $4, %esp
movl %eax, second_ptr

pushl $1300
call allocate
addl $4, %esp
movl %eax, third_ptr

pushl third_ptr
call deallocate
addl $4, %esp

pushl $900
call allocate
addl $4, %esp
movl %eax, fourth_ptr

pushl $380
call allocate
addl $4, %esp
movl %eax, fifth_ptr

call show_heap
*/

movl $SYS_EXIT, %eax
movl $0, %ebx
int $LINUX_SYSCALL
