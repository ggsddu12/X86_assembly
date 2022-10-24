
# boot.bin: boot.asm
# 	nasm boot.asm -o hello.bin
# master.img: boot.bin
# 	dd if=hello.bin of=master.img bs=512 count=1 conv=notrunc

# .PHONY:bochs
# bochs: master.img
# 	bochs -q -unlock
	
# .PHONY:clean
# clean: 
# 	rm -rf *.bin


# %通配符，$<输入文件，$@输出文件	
build/%.bin: src/%.asm
	nasm $< -o $@

build/master.img: build/boot.bin
ifeq ("$(wildcard build/master.img)","")
	bximage -q -hd=16 -func=create -sectsize=512 -imgmode=flat $@
endif
	dd if=$< of=$@ bs=512 count=1 conv=notrunc

.PHONY:bochs
bochs: build/master.img
	cd build && bochs -q -unlock
	
.PHONY:clean
clean: 
	rm -rf build/bx_enh_dbg.ini
	rm -rf build/master.img
	rm -rf build/*.bin