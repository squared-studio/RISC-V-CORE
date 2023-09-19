INST_BASE = 0x0000000000000000;
DATA_BASE = 0x0000000010000000;

SECTIONS
{
   . = INST_BASE;
   .boot   : { *(.boot) }
   .text   : { *(.text) }

   . = DATA_BASE;
   .tohost  : { *(.tohost) }
   .data    : { *(.data) }
   
   _end = .;
}
