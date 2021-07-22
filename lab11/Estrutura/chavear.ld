ENTRY(_start)
SECTIONS {
  . = 0x0;
  .text : {
    irq.o (INTERRUPT_VECTOR)
    *(.text)
  }
  .data : { *(.data) }
  .bss : { *(.bss) }

  . = . + 0x1000; /* 4kiB of stack memory for kernel */
  stack_top = .;

  . = . + 0x1000; /* 4kiB of stack memory for irq */
  irq_stack_top = .;

  . = . + 0x1000; /* 4kiB of stack memory for task A */
  stack_a = .;

  . = . + 0x4;
  linha_a = .;
  . = . + (0x11 << 2); /* 17 words for register saving for A */

  . = . + 0x1000; /* 4kiB of stack memory for task B */
  stack_b = .;

  . = . + 0x4;
  linha_b = .;
  . = . + (0x11 << 2); /* 17 words for register saving for B */
}
