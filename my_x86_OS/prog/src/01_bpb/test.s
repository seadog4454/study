#
# boot.s
#

.code16
.section .text
.globl start
start:
    //setup stack
    mov     $0x7c0, %ax
    mov     %ax, %ss
    mov     $512, %sp

    xor     %ax, %ax    # AX = 0
    mov     %ax, %ds    # Set DS = 0 since origin point is 0x7c00

    //setup video
    xor     %ax, %ax    # Zero 16-bit AX register (includes AL and AH)
    //mov   $0x0, %ax   # Works but is not preferred for zeroing a reg
    int     $0x10

    //print a character say 'm'
    mov     $'m',      %al
    mov     $0x0E,      %ah
    int     $0x10
1:
    jmp 1b
