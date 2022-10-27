	.file	"loop.c"
	.text
	.section	.rodata
.LC0:
	.string	"%d\n"
	.text
	.globl	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$0, -4(%ebp)   # int sum =0
	movl	$10, -8(%ebp)  # int count =10
.L2:
	movl	-8(%ebp), %eax  # eax = count
	addl	%eax, -4(%ebp)  # sum + = eax
	movl	-8(%ebp), %eax  # eax = count
	leal	-1(%eax), %edx  # edx = count -1
	movl	%edx, -8(%ebp)  # count = edx
	testl	%eax, %eax      # eax !=0
	jne	.L2
	pushl	-4(%ebp)
	pushl	$.LC0
	call	printf
	addl	$8, %esp
	movl	$0, %eax
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
