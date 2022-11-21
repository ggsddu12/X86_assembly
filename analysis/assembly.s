	.file	"assembly.c"
	.text
	.globl	a
	.data
	.align 4
	.type	a, @object
	.size	a, 4
a:
	.long	10
	.globl	b
	.align 4
	.type	b, @object
	.size	b, 4
b:
	.long	20
	.globl	result
	.bss
	.align 4
	.type	result, @object
	.size	result, 4
result:
	.zero	4
	.section	.rodata
.LC0:
	.string	"%d + %d = %d\n"
	.text
	.globl	main
	.type	main, @function
main:
	movl	b, %edx
#APP
# 17 "assembly.c" 1
	movl $10, %eax
movl $20, %edx

# 0 "" 2
#NO_APP
	movl	%eax, a
	movl	result, %ecx
	movl	b, %edx
	movl	a, %eax
	pushl	%ecx
	pushl	%edx
	pushl	%eax
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	movl	$0, %eax
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
