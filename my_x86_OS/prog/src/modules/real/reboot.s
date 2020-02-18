.code16
.section .text

reboot:
	push $s_reboot_signal
	call puts
	add $0x2, %sp

.Lreboot1:
	mov $0x10, %ah # wait input key
	int $0x16 # bios call: input key

	cmp $0x20, %al
	jne .Lreboot1

	
	push $s_reboot_newline
	call puts
	add $0x2, %sp

	int $0x19 # bios call: reboot

s_reboot_signal: .string "Push SPACE key to reboot...\r\n"
s_reboot_newline: .string "\r\n\r\n"


