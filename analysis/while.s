	.file	"loop.c"
	.text
	.globl	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$0, -4(%ebp) # sum = 0
	movl	$10, -8(%ebp) # count = 10
	jmp	.L2
.L3:
	movl	-8(%ebp), %eax  # eax = count 
	addl	%eax, -4(%ebp)  # sum = sum + eax
.L2:
	movl	-8(%ebp), %eax  # eax = count 
	leal	-1(%eax), %edx  # edx=eax-1
	movl	%edx, -8(%ebp)  # count = edx
	testl	%eax, %eax      # 
	jne	.L3                 # eax !=0
	movl	$0, %eax
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
