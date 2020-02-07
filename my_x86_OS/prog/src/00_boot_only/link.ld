OUTPUT_FORMAT("binary")
ENTRY(_start);

SECTIONS{
  . = 0x7C00;
  .text : {
    *(.text);

	/* . = 0x7DFE; */
	/* *(sig) */
	/* SHORT(0xAA55); */
	/*
	. = 0x7E00;
  	*(stage_2);
	*/
  }
/* 
  .data : {
    *(.data);
  }

  .bss : {
    *(.bss);
  }
*/
  . = 0x7DFE;
  /*. = 510;*/
  
  .sig : {
    SHORT(0xAA55);
  }
  
  /*
  . = 0x7E00;
  .stage_2 : {
  	*(.stage_2);
  }
  */
}

