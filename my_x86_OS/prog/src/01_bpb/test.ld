OUTPUT_FORMAT("binary");
ENTRY(start);
SECTIONS
{
    . = 0x7C00;
    .text : AT(0x7C00) {
        *(.text);
    }
    .data : SUBALIGN(0) {
        *(.data);
        *(.rodata);
    }
    .bss : SUBALIGN(4) {
        __bss_start = .;
        *(COMMON);
        *(.bss)
        . = ALIGN(4);
        __bss_end = .;
    }
    __bss_sizel = SIZEOF(.bss)>>2;
    __bss_sizeb = SIZEOF(.bss);

    /* Boot signature */
    .sig : AT(0x7DFE) {
        SHORT(0xaa55);
    }
}

