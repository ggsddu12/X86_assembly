	.file	"loop.c"
	.text
	.globl	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$0, -4(%ebp) # int sum = 0
	movl	$1, -8(%ebp) # int i =1
	jmp	.L2
.L3:
	movl	-8(%ebp), %eax # i
	addl	%eax, -4(%ebp) # sum + =i
	addl	$1, -8(%ebp)   # i++
.L2:
	cmpl	$9, -8(%ebp) # 9 - i
	jle	.L3
	movl	$0, %eax
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
