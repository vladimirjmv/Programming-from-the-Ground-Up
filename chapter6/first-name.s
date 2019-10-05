#moja veryija programa count-chars.s
.include "record-def.s"
.include "linux.s"

#STACK LOCAL VARIABLES
.equ FIRST_NAME_BUFFER, 8
.equ BUFFER_LENGTH, 12
.equ BUFFER, 16
.section .text

.globl first_name
.type first_name, @function
first_name:
pushl %ebp
movl %esp, %ebp

movl BUFFER(%ebp), %eax
movl FIRST_NAME_BUFFER(%ebp), %ebx
movl BUFFER_LENGTH(%ebp), %edx
movl $0, %edi

begin_loop:
cmpl $RECORD_LASTNAME, %edi
je end_loop

cmpb $0, (%eax,%edi,1)
je end_loop

movb (%eax,%edi,1), %cl
movb %cl, (%ebx,%edi,1)

incl %edi

jmp begin_loop

end_loop:

movl %ebp, %esp
popl %ebp
ret
