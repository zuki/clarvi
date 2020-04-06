ENTRY(_start)

MEMORY
{
    RAM(xrw)    : ORIGIN = 0x00000000, LENGTH = 0x8000   /* 32KB */
    SDRAM (xrw) : ORIGIN = 0x01000000, LENGTH = 0x800000 /*  8 MB */
}

SECTIONS
{
    .text.init : {
        *(.text.init)
        *(.vectors)
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
        . = ALIGN(4);
        _edata = .;
        __global_pointer$ = . + 0x800;
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

    /* スレッドローカルなデータセクション */
    .tdata : {
      . = ALIGN(4);
      _tls_data = .;
      _tdata_begin = .;
      KEEP(*(.tdata .tdata.*));
      _tdata_end = .;
      . = ALIGN(4);
    } > RAM

    .tbss  : {
      . = ALIGN(4);
      _tbss_begin = .;
      KEEP(*(.tbss .tbss.*));
      . = ALIGN(4);
      _tbss_end = .;
    } > RAM

    __TLS_SIZE__ = _tbss_end - _tdata_begin;

    __TLS0_BASE__ = __C_STACK_TOP__ - __TLS_SIZE__;

    .stack : {
      _data_end = ORIGIN(RAM)+LENGTH(RAM);
      . = _data_end - 4;
      _stack_pointer = .;
      __C_STACK_TOP__ = .;
    } > RAM

    /DISCARD/ : {
      *(.eh_frame .eh_frame.*)
    }

}
