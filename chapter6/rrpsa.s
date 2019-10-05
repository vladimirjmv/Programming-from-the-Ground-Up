#moja verzija programa add-year.s
.include "linux.s"
.include "record-def.s"

.section .data
file_name:
.ascii "test.dat\0"

.section .bss
.lcomm RECORD, RECORD_SIZE

.section .text
.equ ST_FILE_DESCRIPTOR, -4
.equ ST_OUT, -8

.globl _start
_start:

movl %esp, %ebp

subl $8, %esp

movl $SYS_OPEN, %eax
movl $file_name, %ebx
movl $0, %ecx
movl $0666, %edx
int $LINUX_SYSCALL

movl %eax, ST_FILE_DESCRIPTOR(%ebp)

movl $1, ST_OUT(%ebp)

loop_through_records:

pushl ST_FILE_DESCRIPTOR(%ebp)
pushl $RECORD
call read_record
addl $8, %esp

cmpl $RECORD_SIZE, %eax
jne end_program

movl $RECORD_AGE + RECORD, %ecx
incb (%ecx)


movl $4, %edx
movl $SYS_WRITE, %eax
movl ST_OUT(%ebp), %ebx
movl $RECORD_AGE + RECORD, %ecx
int $LINUX_SYSCALL

pushl ST_OUT(%ebp)
call write_newline
addl $4, %esp

jmp loop_through_records

end_program:

#Close the file descriptor
movl $SYS_CLOSE, %eax
movl ST_FILE_DESCRIPTOR(%ebp), %ebx
int $LINUX_SYSCALL

#Close the screen descriptor
movl $SYS_CLOSE, %eax
movl ST_OUT(%ebp), %ebx
int $LINUX_SYSCALL

#Exit the program
movl $SYS_EXIT, %eax
movl $0, %ebx
int $LINUX_SYSCALL
