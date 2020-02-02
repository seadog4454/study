OUTPUT_FORMAT("binary")
ENTRY(_start);

SECTIONS{
  . = 0x7C00;
  .text : {
    *(.text);
  }
  
  .data : {
    *(.data);
  }

  .bss : {
    *(.bss);
  }

  . = 0x7DFE;
  /*. = 510;*/
  .sig : {
    SHORT(0xAA55);
  }
}
