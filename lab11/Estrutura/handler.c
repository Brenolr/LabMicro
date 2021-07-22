#include "print.h"

void print_hashtag() {
  print_uart0("#");
}

void print_espaco() {
  /*print_uart0(" ");*/
}

void c_entry() {
  print_uart0("Hello world!\n");
}

void undefined() {
  print_uart0("indefinida\n");
}