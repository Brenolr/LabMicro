#ifndef MY_PRINT_H
#define MY_PRINT_H

void print_uart0(const char *s);

#define UART_MAGIC ((unsigned int *)0x101f1000)
#define INLINE_PRINT_CHAR(c) ((*UART_MAGIC) = c)

#endif
