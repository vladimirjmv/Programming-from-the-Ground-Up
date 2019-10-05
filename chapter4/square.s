.section .data
					
.section .text
.globl _start
_start:

pushl $10 							
call square
addl $4, %esp 		
pushl %eax

pushl $4
call square
addl $4, %esp
popl %ebx

addl %eax, %ebx	
movl $1, %eax 		#call the kernel’s exit function
int $0x80


.type square,@function
square:

pushl %ebp
movl %esp, %ebp

movl 8(%ebp), %eax
imull 8(%ebp), %eax


movl %ebp, %esp
popl %ebp
ret
