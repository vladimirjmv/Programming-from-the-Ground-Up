
.section .data
	text:
		.ascii "Output %x\n \0"
	text2:
		.ascii "eql \n \0"
	text3:
		.ascii "neql \n \0"		
.global _start
_start:



#movl $0x00000002, %edx
#shll $1, %edx

#andl $0x00000002, %edx

#cmpl $0x00000002, %edx
#je eql

#jne neql

#eql:

#pushl $text2
#call printf
#addl $4, %esp

#jmp exit
#neql:

#pushl $text3
#call printf
#addl $4, %esp

movl $0xfffffffe, %edx

pushl %edx
pushl $text
call printf
addl $4, %esp

exit:
movl $1, %eax
movl $1, %ebx

int $0x80
