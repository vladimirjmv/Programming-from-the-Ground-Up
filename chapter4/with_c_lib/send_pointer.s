


.section .data
	text:
		.ascii "local number(before function): %d \n\0"
		
	text2:
		.ascii "local number(with pointer, in function): %d \n\0"

	text3:
		.ascii "local number(with pointer, after function): %d \n\0"	
			

.section .text
.global _start
_start:

movl %esp, %ebp
subl $4, %esp

movl $10, -4(%ebp)

pushl -4(%ebp)
pushl $text
call printf

movl %ebp, %eax
subl $4, %eax		#%eax points on local variable (%eax) actual value

pushl %eax
call pointer
addl $4, %esp

pushl -4(%ebp)
pushl $text3
call printf
addl $8, %esp

movl $1, %eax
movl $0, %ebx

int $0x80



.type pointer, @function
pointer:

pushl %ebp
movl %esp, %ebp

movl 8(%ebp), %ebx
addl $55, (%ebx)

pushl (%ebx)
pushl $text2
call printf

movl %ebp, %esp
popl %ebp
ret
