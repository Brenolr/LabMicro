#include "print.h"

int task_a(void) {
  for (;;) INLINE_PRINT_CHAR('1');
}

void task_b(void) {
  for (;;) INLINE_PRINT_CHAR('2');
}
