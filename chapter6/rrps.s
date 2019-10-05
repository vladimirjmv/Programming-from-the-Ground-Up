#moja verzija programa read-records.s
.include "linux.s"
.include "record-def.s"

.section .data
file_name:
.ascii "test.dat\0"

.section .bss
.lcomm RECORD, RECORD_SIZE

.lcomm FIRST_NAME, RECORD_LASTNAME

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

cmpl $0, %eax
jle end_program

pushl $RECORD
pushl %eax
pushl $FIRST_NAME
call first_name
addl $12, %esp


movl %eax, %edx
movl $SYS_WRITE, %eax
movl ST_OUT(%ebp), %ebx
movl $FIRST_NAME, %ecx
int $LINUX_SYSCALL

pushl ST_OUT(%ebp)
call write_newline
addl $4, %esp

movl $0, %edi
set_zero:
cmp $40, %edi
je end_zero

movb $0, FIRST_NAME(,%edi,1)
incl %edi

jmp set_zero
end_zero:

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
