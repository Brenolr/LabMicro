#include "print.h"

volatile unsigned int * const UART0DR = UART_MAGIC;

void print_uart0(const char *s) {
  while (*s != '\0') { /* Loop until end of string */
    *UART0DR = (unsigned int)(*s); /* Transmit char */
    s++; /* Next char */
  }
}
