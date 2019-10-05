.include "linux.s"
.include "record-def.s"

.section .data
	read_file:
		.ascii "read_file.dat\0"
	write_file:
		.ascii "write_file.dat\0"

	ages:
		.ascii "ages of ppl: %d \n"

.section .bss
	.lcomm record_buffer, RECORD_SIZE

.section .text
.global _start

_start:

.equ ST_INPUT_DESCRIPTOR, -4
.equ ST_OUTPUT_DESCRIPTOR, -8


movl %esp, %ebp
subl $8, %esp

# open file for erading
movl $SYS_OPEN, %eax
movl $read_file, %ebx
movl $0, %ecx 	#This says to open read-only
movl $0666, %edx
int $LINUX_SYSCALL

movl %eax, ST_INPUT_DESCRIPTOR(%ebp)


# open file for writing
movl $SYS_OPEN, %eax
movl $write_file, %ebx
movl $0101, %ecx 
movl $0666, %edx
int $LINUX_SYSCALL
			
movl %eax, ST_OUTPUT_DESCRIPTOR(%ebp)


record_read_loop:

pushl ST_INPUT_DESCRIPTOR(%ebp)
pushl $record_buffer
call read_record
addl $8, %esp

cmpl $RECORD_SIZE, %eax
jne finished_reading

movl $RECORD_AGE + record_buffer, %ecx
incl (%ecx)

#pushl (%ecx)
#pushl $ages
#call printf

#addl $8, %esp

pushl ST_OUTPUT_DESCRIPTOR(%ebp)
pushl $record_buffer
call write_record
addl $8, %esp

jmp record_read_loop

finished_reading:

#Close the file descriptor
movl $SYS_CLOSE, %eax
movl ST_INPUT_DESCRIPTOR(%ebp), %ebx
int $LINUX_SYSCALL

#Close the file descriptor
movl $SYS_CLOSE, %eax
movl ST_OUTPUT_DESCRIPTOR(%ebp), %ebx
int $LINUX_SYSCALL


movl $SYS_EXIT, %eax
movl $0, %ebx
int $LINUX_SYSCALL
