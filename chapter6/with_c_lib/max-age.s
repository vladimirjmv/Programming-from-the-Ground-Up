.include "linux.s"
.include "record-def.s"

.section .data
	read_file:
		.ascii "read_file.dat\0"
	write_file:
		.ascii "write_file.dat\0"

	ages:
		.ascii "Age of ppl: %d \n\0"

	max:
		.ascii "Max age: %d \n\0"

.section .bss
	.lcomm record_buffer, RECORD_SIZE

.section .text
.global _start

_start:

.equ ST_INPUT_DESCRIPTOR, -4
.equ MAX, -8

movl %esp, %ebp
subl $8, %esp

# open file for erading
movl $SYS_OPEN, %eax
movl $read_file, %ebx
movl $0, %ecx 	#This says to open read-only
movl $0666, %edx
int $LINUX_SYSCALL

movl %eax, ST_INPUT_DESCRIPTOR(%ebp)

pushl ST_INPUT_DESCRIPTOR(%ebp)
pushl $record_buffer
call read_record
addl $8, %esp

cmpl $RECORD_SIZE, %eax
jne finished_reading

movl $RECORD_AGE + record_buffer, %edx
movl (%edx), %ecx
movl %ecx, MAX(%ebp)   # max age 

# print current age of ppl

pushl (%edx)
pushl $ages
call printf
addl $8, %esp

record_read_loop:

pushl ST_INPUT_DESCRIPTOR(%ebp)
pushl $record_buffer
call read_record
addl $8, %esp

cmpl $RECORD_SIZE, %eax
jne finished_reading

movl $RECORD_AGE + record_buffer, %edx
movl MAX(%ebp), %ecx

cmpl (%edx), %ecx
jg continue # jg max jl min

movl (%edx), %ecx
movl %ecx, MAX(%ebp)

continue:

# print current age of ppl

pushl (%edx)
pushl $ages
call printf
addl $8, %esp

jmp record_read_loop

finished_reading:

#print max
pushl MAX(%ebp)
pushl $max
call printf
addl $8, %esp

#Close the file descriptor
movl $SYS_CLOSE, %eax
movl ST_INPUT_DESCRIPTOR(%ebp), %ebx
int $LINUX_SYSCALL

movl $SYS_EXIT, %eax
movl $0, %ebx
int $LINUX_SYSCALL
