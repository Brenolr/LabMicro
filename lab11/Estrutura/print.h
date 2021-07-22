#ifndef MY_PRINT_H
#define MY_PRINT_H

void print_uart0(const char *s);

#define UART_MAGIC ((unsigned int *)0x101f1000)
#define INLINE_PRINT_CHAR(c) ((*UART_MAGIC) = c)
#define INLINE_PRINT_STR(s) do { const char *_s = s; while (*_s) { INLINE_PRINT_CHAR(*_s); _s++; } } while (0)

#endif
