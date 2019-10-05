.section .data
	string:
		.ascii "value: %d \n \0"
.section .text

.global _start
_start:

pushl $5
call recursive
addl $4, %esp

movl %eax, %ebx

movl $1, %eax
int $0x80



.type recursive, @function
recursive:

pushl %ebp
movl %esp, %ebp

movl $1, %eax

cmpl $1, 8(%ebp)
je f_end

movl 8(%ebp), %ecx
decl %ecx
push %ecx
call recursive
addl $4, %esp

imull 8(%ebp), %eax

f_end:

movl %ebp, %esp
popl %ebp
ret
