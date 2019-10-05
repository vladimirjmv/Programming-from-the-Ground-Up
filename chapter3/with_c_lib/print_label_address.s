#PURPOSE: Simple program that exits and returns a
				# status code back to the Linux kernel
				#
#INPUT: none
				#
#OUTPUT: returns a status code. This can be viewed
				# by typing
				#
				# echo $?
				#
				# after running the program
				#
#VARIABLES:
				# %eax holds the system call number
				# %ebx holds the return status
				#
.section .data
	arguments:
		.ascii "number %x\n number %x\n\ string %s\n number %x\n start %x \n\0"

	integer: 
		.long 665

	integer2: 
		.long 6651
	string:
		.ascii "Vlad\0"

	integer3: 
		.long 6651
.section .text
.globl _start
_start:

pushl $_start
pushl $integer3
pushl $string
pushl $integer2
pushl $integer
pushl $arguments
call printf

movl $1, %eax 	# this is the linux kernel command
				# number (system call) for exiting
				# a program

movl $0, %ebx 	# this is the status number we will
				# return to the operating system.
				# Change this around and it will
				# return different things to
				# echo $?
int $0x80 		# this wakes up the kernel to run
				# the exit command
