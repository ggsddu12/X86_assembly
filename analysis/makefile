
CFLAGS:= -fno-asynchronous-unwind-tables \
		 -fno-pic \
		 -fno-stack-protector \
		 -mpreferred-stack-boundary=2 \
		 -m32 \
		 -fno-builtin \
		 -fomit-frame-pointer \
		 -static \
		 -O0 
.PHONY: hello.s
hello.s: hello.c 
	gcc $(CFLAGS) -S $< -o $@

.PHONY: variable.s
variable.s: variable.c
	gcc $(CFLAGS) -S $< -o $@

%.s: %.c
	gcc $(CFLAGS) -S $< -o $@	


DEBUG:=-g

%.o: %.asm
	nasm -f elf32 -g $(DEBUG) $< -o $@

%.o: %.c
	gcc $(CFLAGS) $(DEBUG) -c $< -o $@
.PHONY: call.out
call.out: call.o subcall.o
	gcc $(CFLAGS) $(DEBUG) $^ -o $@	