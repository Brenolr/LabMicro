#!/bin/bash

alias qemu='qemu-system-arm -M versatilepb -m 128M -nographic -s -S -kernel'
alias eabi-qemu='arm-none-eabi-gdb -tui --command=/home/student/.gdbinit/qemu'

# No primeiro terminal

eabi-gcc handler.c -o handler.o  && eabi-as irq.s -o irq.o && eabi-ld -T irqld.ld irq.o handler.o -o irq.elf && eabi-bin irq.elf irq.bin && qemu irq.bin

