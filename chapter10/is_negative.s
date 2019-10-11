
.equ ST_VALUE, 8

.globl is_negative
.type is_negative, @function
is_negative:

pushl %ebp
movl %esp, %ebp

movl ST_VALUE(%ebp), %ebx
movl $0, %eax

#movl $0x80000000, %ecx
andl $0x80000000, %ebx

cmpl $0x80000000, %ebx
jne end_of_function

movl $1, %eax

end_of_function:

movl %ebp, %esp
popl %ebp
ret
