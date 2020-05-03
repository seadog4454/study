
# initialize task 0
TSS_0:
TSS_0.link: .long 0x0
TSS_0.esp0: .long SP_TASK_0 - 512
TSS_0.ss0: .long DS_KERNEL
TSS_0.esp1: .long 0x0
TSS_0.ss1: .long 0x0
TSS_0.esp2: .long 0x0
TSS_0.ss2: .long 0x0
TSS_0.cr3: .long 0x0
TSS_0.eip: .long 0x0
TSS_0.eflags: .long 0x0
TSS_0.eax: .long 0x0
TSS_0.ecx: .long 0x0
TSS_0.edx: .long 0x0
TSS_0.ebx: .long 0x0
TSS_0.esp: .long 0x0
TSS_0.ebp: .long 0x0
TSS_0.esi: .long 0x0
TSS_0.edi: .long 0x0
TSS_0.es: .long 0x0
TSS_0.cs: .long 0x0
TSS_0.ss: .long 0x0
TSS_0.ds: .long 0x0
TSS_0.fs: .long 0x0
TSS_0.gs: .long 0x0
TSS_0.ldt: .long 0x0
TSS_0.io: .long 0x0



TSS_1:
TSS_1.link: .long 0x0
TSS_1.esp0: .long SP_TASK_1 - 512
TSS_1.ss0: .long DS_KERNEL
TSS_1.esp1: .long 0x0
TSS_1.ss1: .long 0x0
TSS_1.esp2: .long 0x0
TSS_1.ss2: .long 0x0
TSS_1.cr3: .long 0x0
TSS_1.eip: .long task_1
TSS_1.eflags: .long 0x0202
TSS_1.eax: .long 0x0
TSS_1.ecx: .long 0x0
TSS_1.edx: .long 0x0
TSS_1.ebx: .long 0x0
TSS_1.esp: .long SP_TASK_1
TSS_1.ebp: .long 0x0
TSS_1.esi: .long 0x0
TSS_1.edi: .long 0x0
TSS_1.es: .long DS_TASK_1
TSS_1.cs: .long CS_TASK_1
TSS_1.ss: .long DS_TASK_1
TSS_1.ds: .long DS_TASK_1
TSS_1.fs: .long DS_TASK_1
TSS_1.gs: .long DS_TASK_1
TSS_1.ldt: .long SS_LDT
TSS_1.io: .long 0x0



GDT: .quad 0x0000000000000000
GDT.cs_kernel: .quad 0x00CF9A000000FFFF # CODE 4G
GDT.ds_kernel: .quad 0x00CF92000000FFFF # DATA 4G
GDT.ldt: .quad 0x0000820000000000
GDT.tss_0: .quad 0x0000890000000067
GDT.tss_1: .quad 0x0000890000000067
GDT.GDT_end:

.set CS_KERNEL, GDT.cs_kernel - GDT
.set DS_KERNEL, GDT.ds_kernel - GDT
.set SS_LDT, GDT.ldt - GDT
.set SS_TASK_0, GDT.tss_0 - GDT
.set SS_TASK_1, GDT.tss_1 - GDT

GDTR: .word GDT.GDT_end - GDT - 1
.long GDT



LDT: .quad 0x0000000000000000
LDT.cs_task_0: .quad 0x00CF9A000000FFFF # CODE 4G
LDT.ds_task_0: .quad 0x00CF92000000FFFF # DATA 4G
LDT.cs_task_1: .quad 0x00CF9A000000FFFF # CODE 4G
LDT.ds_task_1: .quad 0x00CF92000000FFFF # DATA 4G
LDT.LDT_end:

.set CS_TASK_0, (LDT.cs_task_0 - LDT) | 4
.set DS_TASK_0, (LDT.ds_task_0 - LDT) | 4
.set CS_TASK_1, (LDT.cs_task_1 - LDT) | 4
.set DS_TASK_1, (LDT.ds_task_1 - LDT) | 4

.set LDT_LIMIT, LDT.LDT_end - LDT - 1

