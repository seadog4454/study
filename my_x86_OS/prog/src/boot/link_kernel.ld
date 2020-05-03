OUTPUT_FORMAT("binary")
OUTPUT_ARCH(i386:x86-64)
ENTRY(kernel);

SECTIONS{
  . = 0x00101000;
  .text : {
    *(.text)
	}
}
