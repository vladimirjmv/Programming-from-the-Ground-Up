.section .data

	.equ PERSON_SIZE, 84
	.equ PERSON_FIRSTNAME_OFFSET, 0
	.equ PERSON_LASTNAME_OFFSET, 40
	.equ PERSON_AGE_OFFSET, 80

	.equ P_VAR, 0 - PERSON_SIZE

	string:
		.ascii "Vrednost je: %d \n\0"
.section .text

.globl _start
_start:

movl %esp, %ebp
subl $PERSON_SIZE, %esp
movl $30, P_VAR + PERSON_AGE_OFFSET(%ebp)

pushl P_VAR + PERSON_AGE_OFFSET(%ebp)
pushl $string
call printf 


movl $1, %eax
movl $0, %ebx
int $0x80
