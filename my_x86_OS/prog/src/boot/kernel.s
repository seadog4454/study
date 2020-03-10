.code32

kernel:
	
	jmp .
.set KERNEL_SIZE, 8192
.fill KERNEL_SIZE - (. - kernel), 0x1, 0x0
