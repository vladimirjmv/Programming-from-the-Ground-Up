.global _start
_start:


pushl $-9999
call is_negative
addl $4, %esp

movl %eax, %ebx #result in ebx

movl $1, %eax
int $0x80
