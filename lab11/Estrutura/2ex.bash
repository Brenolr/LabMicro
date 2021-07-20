#!/bin/bash

alias qemu='qemu-system-arm -M versatilepb -m 128M -nographic -s -S -kernel'
alias eabi-qemu='arm-none-eabi-gdb -tui --command=/home/student/.gdbinit/qemu'
eabi-qemu -se irq.elf

