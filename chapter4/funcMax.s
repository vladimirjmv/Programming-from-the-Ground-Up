.section .data

	data_items: 
		.long 3,67,34,222,45,75,54,34,44,33,22,11,66
	data_list_size:
		.long 13	


	data_items_1: 
		.long 225,67,34,222,45,75,54,34,44,33,22,11,66
	data_list_size_1:
		.long 13	

.equ ST_OLD_BASE, 0 	#
.equ ST_RET_ADR, 4 		#
.equ ST_ARGV_1, 8 		#
.equ ST_ARGV_2, 12 		#

.equ LINUX_SYSCALL, 0x80

.section .text
.globl _start
_start:

push data_list_size
push $data_items

call max
push %eax

push data_list_size_1
push $data_items_1

call max
popl %ebx

movl $1, %eax

int $LINUX_SYSCALL


.type max,@function
max:
	pushl %ebp
	movl %esp, %ebp

					
    movl ST_ARGV_2(%ebp), %ecx
    movl ST_ARGV_1(%ebp), %ebx
 	
 	
 	movl (%ebx), %eax

 	movl $0, %edi
 	loop_begin:
 	incl %edi
 	
 	cmp %edi, %ecx
 	je loop_end

 	
 	cmp (%ebx,%edi,4), %eax 	#ova fora je uzeta iz narednih poglavnja knjige
 	jg loop_begin
 	movl (%ebx,%edi,4), %eax

 	jmp loop_begin


 	loop_end:

	movl %ebp, %esp
	popl %ebp
ret
