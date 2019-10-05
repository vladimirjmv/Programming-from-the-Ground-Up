


.section .data
	text:
		.ascii "number: %d \n\0"

	text2:
		.ascii "ebp: %x \n\0"

	text3:
		.ascii "esp: %x \n\0"	

	text4:
		.ascii "esp: %x \n\0"			

.section .text
.global _start
_start:
				#base pointer je inicijaliyovan na 0 na pocetku programa

movl %esp, %ebp

pushl %ebp
pushl $text2
call printf
addl $8, %esp

pushl %esp
pushl $text4
call printf
addl $8, %esp

#push %ebp
#movl %esp, %ebp

pushl (%ebp)
pushl $text2
call printf
addl $8, %esp

pushl (%esp)
pushl $text4
call printf
addl $8, %esp

call fnc 


movl $1, %eax
movl $0, %ebx

int $0x80



.type fnc, @function
fnc:

pushl %ebp
movl %esp, %ebp

pushl $1000
pushl $text
call printf

movl %ebp, %esp
popl %ebp
ret
