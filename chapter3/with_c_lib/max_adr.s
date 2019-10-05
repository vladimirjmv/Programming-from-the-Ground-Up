#PURPOSE: This program finds the maximum number of a
# set of data items.
#
#VARIABLES: The registers have the following uses:
#
# %edi - Holds the index of the data item being examined
# %ebx - Largest data item found
# %eax - Current data item
#
# The following memory locations are used:
#
# data_items - contains the item data. A 0 is used
# to terminate the data
#
.section .data
 	data_items: #These are the data items
		.long 3,67,34,222,45,75,54,34,44,33,22,11,350
	text:
		.ascii "address of the last element in the list %d \n"
	text2:
		.ascii "address of the current element in the list %d \n"
	text3:
		.ascii "max number: %d \n"

.section .text
.globl _start
_start:

movl $0, %edi 					# move 0 into the index register
movl data_items(,%edi,4), %eax 	# load the first byte of data
movl %eax, %ebx 				# since this is the first item, %eax is
								# the biggest
movl $12, %esi
leal data_items(,%esi,4), %esi

start_loop: 					# start loop

leal data_items(,%edi,4), %edx

cmpl %esi, %edx
je loop_exit

incl %edi 						# load next value
movl data_items(,%edi,4), %eax

cmpl %ebx, %eax 				# compare values
jle start_loop 					# jump to loop beginning if the new
								# one isn’t bigger
movl %eax, %ebx 				# move the value as the largest

jmp start_loop 					# jump to loop beginning
loop_exit:
								# %ebx is the status code for the exit system call
								# and it already has the maximum number

pushl %ebx
pushl $text3
call printf 


movl $1, %eax 					#1 is the exit() syscall
movl $0, %ebx
int $0x80
