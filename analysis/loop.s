	.file	"loop.c"
	.text
	.section	.rodata
.LC0:
	.string	"%d %d\n"
	.text
	.globl	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$12, %esp
	movl	$0, -4(%ebp)
	movl	$10, -8(%ebp)
	movl	$0, -12(%ebp)
.L2:
	addl	$1, -12(%ebp)
	movl	-8(%ebp), %eax
	addl	%eax, -4(%ebp)
	movl	-8(%ebp), %eax
	leal	-1(%eax), %edx
	movl	%edx, -8(%ebp)
	testl	%eax, %eax
	jne	.L2
	pushl	-12(%ebp)
	pushl	-4(%ebp)
	pushl	$.LC0
	call	printf
	addl	$12, %esp
	movl	$0, %eax
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
