/*
 * Default linker script for baremetal RISC-V applications.
 * This is a generic script suitable for simple programs that are loaded
 * into memory and executed from the beginning.
 */

OUTPUT_ARCH( "riscv" )
ENTRY( _start )

MEMORY
{
  /* Main memory, starting at the standard RISC-V address. */
  ram (wxa!ri) : ORIGIN = 0x80000000, LENGTH = 128K
}

SECTIONS
{
  .text :
  {
    *(.text.init)
    *(.text)
    *(.text.*)
  } > ram

  .rodata :
  {
    . = ALIGN(4);
    *(.rodata)
    *(.rodata.*)
  } > ram

  .data :
  {
    . = ALIGN(4);
    *(.data)
    *(.data.*)
  } > ram

  .bss :
  {
    . = ALIGN(4);
    *(.bss)
    *(.bss.*)
  } > ram

  _end = .;
} 