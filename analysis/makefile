
.PHONY: hello.s
hello.s: hello.c 
	gcc  -fno-asynchronous-unwind-tables \
	-fno-pic \
	-mpreferred-stack-boundary=2 \
	-m32 \
	-S hello.c \
	-o  hello.s