/* 128KB of SRAM on STM32F411RE line 128K = 0x20000 */
/* RAM starts at address 0x20000000 */
_estack = ORIGIN(RAM) + LENGTH(RAM);

/* Set minimum size for stack and dynamic memory. */
/* (The linker will generate an error if there is
 * less than this much RAM leftover.) */
/* (1KB) */
_Min_Leftover_RAM = 0x400;

MEMORY
{
	FLASH ( rx ) : ORIGIN = 0x08000000, LENGTH = 512K
	RAM ( rwx ) : ORIGIN = 0x20000000, LENGTH = 128K
}


SECTIONS
{

  /* Interrupt vector table (must be first, at FLASH origin) */
  .vector_table :
 {
    . = ALIGN(4);
    KEEP(*(.vector_table))
    . = ALIGN(4);
  } >FLASH
   
  /* Stores executable code */
  .text :
  {
    . = ALIGN(4);
    *(.text)
    *(.text*)
    . = ALIGN(4);
  } >FLASH

  /* Stores const globals and string literals */
  .rodata :
  {
    . = ALIGN(4);
    *(.rodata)
    *(.rodata*)
    . = ALIGN(4);
  } >FLASH

  _sidata = .;

  /* Stores global/static variables that can be modified at runtime */
  .data : AT(_sidata)
  {
	  . = ALIGN(4);
	  _sdata = .;
	  *(.data)
	  *(.data*)
	  . = ALIGN(4);
	  _edata = .;
  } >RAM

  /* Store uninitialized global static variables */
  .bss :
  {
	  . = ALIGN(4);
	  _sbss = .;
	  *(.bss)
	  *(.bss*)
	  *(COMMON)
	  . = ALIGN(4);
	  _ebss = .;
  } >RAM

  .dynamic_allocations :
  {
	  . = ALIGN(4);
	  _ssystem_ram = .;
	  . = . + _Min_Leftover_RAM;
	  . = ALIGN(4);
	  _esystem_ram = .;
  } >RAM
  }
