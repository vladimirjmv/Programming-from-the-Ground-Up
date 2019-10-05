.section .data
#######CONSTANTS########
#system call numbers

.equ SYS_CLOSE, 6
.equ SYS_OPEN, 5
.equ SYS_WRITE, 4
.equ SYS_READ, 3
.equ SYS_EXIT, 1

.equ O_RDONLY, 0
.equ O_CREAT_WRONLY_TRUNC, 03101

#standard file descriptors
.equ STDIN, 0
.equ STDOUT, 1
.equ STDERR, 2

.equ LINUX_SYSCALL, 0x80
.equ END_OF_FILE, 0

.section .bss

.equ BUFFER_SIZE, 500
.lcomm BUFFER_DATA, BUFFER_SIZE


.section .text

#STACK POSITIONS
.equ ST_SIZE_RESERVE, 12
.equ ST_FD_IN, -4
.equ ST_FD_OUT, -8
.equ ARGV_0_START, -12
.equ ST_ARGC, 0 	#Number of arguments
.equ ST_ARGV_0, 4 	#Name of program
.equ ST_ARGV_1, 8 	#String
.equ ST_ARGV_2, 12 	#File to print

.globl _start
_start:

movl %esp, %ebp

subl $ST_SIZE_RESERVE, %esp

#movl ST_ARGV_1(%ebp), %ecx
#
#cmpl $0, %ecx #ako nema argmenata
#je end_program
#
#cmpl $0, (%ecx)
#je end_program

open_fd_in:
###OPEN INPUT FILE###

movl $SYS_OPEN, %eax
movl ST_ARGV_1(%ebp), %ebx
movl $O_RDONLY, %ecx
movl $0666, %edx
int $LINUX_SYSCALL

store_fd_in:
movl %eax, ST_FD_IN(%ebp)

open_fd_out:
###OPEN OUTPUT FILE###

movl $SYS_OPEN, %eax
movl ST_ARGV_2(%ebp), %ebx
movl $O_CREAT_WRONLY_TRUNC, %ecx
movl $0666, %edx
int $LINUX_SYSCALL

store_fd_out:
movl %eax, ST_FD_OUT(%ebp)

read_loop_begin:
movl $SYS_READ, %eax
movl ST_FD_IN(%ebp), %ebx
movl $BUFFER_DATA, %ecx
movl $BUFFER_SIZE, %edx
int $LINUX_SYSCALL

cmpl $END_OF_FILE, %eax
jle end_loop
continue_read_loop:

movl %eax, %edx
movl $SYS_WRITE, %eax
movl ST_FD_OUT(%ebp), %ebx
movl $BUFFER_DATA, %ecx
int $LINUX_SYSCALL

jmp read_loop_begin
end_loop:

#end_program:

movl $SYS_CLOSE, %eax
movl ST_FD_OUT(%ebp), %ebx
int $LINUX_SYSCALL

movl $SYS_CLOSE, %eax
movl ST_FD_IN(%ebp), %ebx
int $LINUX_SYSCALL

	###EXIT###
movl $SYS_EXIT, %eax
movl $0, %ebx
int $LINUX_SYSCALL
