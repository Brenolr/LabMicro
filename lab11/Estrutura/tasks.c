#include "print.h"

const char *nome = "Bruno Borges Paschoalinoto\n";
const char *nusp = "10687472\n";
const char *ptr1, *ptr2;

void task_a(void) {
  ptr1 = nome;
  for (;;) {
    INLINE_PRINT_CHAR(*ptr1);
    ptr1++;
    if (!*ptr1) ptr1 = nome;
  }
}

void task_b(void) {
  ptr2 = nusp;
  for (;;) {
    INLINE_PRINT_CHAR(*ptr2);
    ptr2++;
    if (!*ptr2) ptr2 = nusp;
  }
}
