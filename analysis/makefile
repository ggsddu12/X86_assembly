
CFLAGS:= -fno-asynchronous-unwind-tables \
		 -fno-pic \
		 -fno-stack-protector \
		 -mpreferred-stack-boundary=2 \
		 -m32 \
		 -fno-builtin \
		 -O0 
.PHONY: hello.s
hello.s: hello.c 
	gcc $(CFLAGS) -S $< -o $@

.PHONY: variable.s
variable.s: variable.c
	gcc $(CFLAGS) -S $< -o $@

%.s: %.c
	gcc $(CFLAGS) -S $< -o $@	