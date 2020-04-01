ENTRY(entry)

MEMORY
{
    RAM(xrw)  : ORIGIN = 0x00000000, LENGTH = 0x8000  /* 32KB */
}

SECTIONS
{
    .text.init : {
        *(.text.init)
    } > RAM

    .text : {
        . = ALIGN(4);
        *(.text)
        *(.rodata)
        . = ALIGN(4);
        _etext = .;
        _sidata = _etext;
    } > RAM

    .data : {
        . = ALIGN(4);
        _sdata = .;
        *(.data*)
        *(.sdata)
        *(.got*)
        . = ALIGN(4);
        _edata = .;
    } > RAM

    .bss : {
      . = ALIGN(4);
      _sbss = .;
      *(.bss)
      *(.sbss)
      *(COMMON)
      . = ALIGN(4);
      _ebss = .;
    } > RAM

    _data_end = ORIGIN(RAM)+LENGTH(RAM);
    PROVIDE(_stack_pointer = _data_end);
}
