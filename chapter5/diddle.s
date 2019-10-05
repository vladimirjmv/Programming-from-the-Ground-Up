.section .data
	text:
		.ascii "Hey diddle diddle!!!"

#######CONSTANTS########
#system call numbers

.equ SYS_CLOSE, 6
.equ SYS_OPEN, 5
.equ SYS_WRITE, 4
.equ SYS_READ, 3
.equ SYS_EXIT, 1

.equ O_CREAT_WRONLY_TRUNC, 03101

.equ LINUX_SYSCALL, 0x80
.equ END_OF_FILE, 0

#standard file descriptors
.equ STDIN, 0

.section .text

.equ ST_SIZE_RESERVE, 4

.equ ST_ARGV_1, 8 	#File to print
.equ ST_ARGV_0, 4 	#Name of program
.equ ST_ARGC, 0 	#Number of arguments
.equ ST_FD_OUT, -4  #File descriptor

.globl _start
_start:

movl %esp, %ebp
subl $ST_SIZE_RESERVE, %esp

open_fd_in:

movl $SYS_OPEN, %eax
movl ST_ARGV_1(%ebp),%ebx
movl $O_CREAT_WRONLY_TRUNC,%ecx
movl $0666,%edx
int $LINUX_SYSCALL

store_fd_out:
movl %eax, ST_FD_OUT(%ebp)

write_data:

movl $SYS_WRITE, %eax
movl ST_FD_OUT(%ebp), %ebx
movl $text, %ecx
movl $20, %edx
int $LINUX_SYSCALL

movl $SYS_CLOSE,%eax
movl ST_FD_OUT(%ebp), %ebx
int $LINUX_SYSCALL

movl $SYS_EXIT, %eax
movl $0, %ebx
int $LINUX_SYSCALL
