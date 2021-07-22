# aliases roubados do bash
alert=notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"
arm=arm-elf-gcc -S
e7t=arm-elf-gdb -tui --command=/home/student/.gdbinit/evaluator7t
eabi-as=arm-none-eabi-as -c -mcpu=arm926ej-s -g
eabi-bin=arm-none-eabi-objcopy -O binary
eabi-gcc=arm-none-eabi-gcc -c -mcpu=arm926ej-s -Wall -Wextra -g
eabi-gdb=arm-none-eabi-gdb -tui --command=/home/student/.gdbinit/default
eabi-ld=arm-none-eabi-ld
eabi-qemu=arm-none-eabi-gdb -tui --command=/home/student/.gdbinit/qemu
egrep=egrep --color=auto
fgrep=fgrep --color=auto
gcc=arm-elf-gcc -Wall -Wextra -g
gdb=arm-elf-gdb -tui --command=/home/student/.gdbinit/default
grep=grep --color=auto
l=ls -CF
la=ls -A
ll=ls -alF
ls=ls --color=auto
qemu=qemu-system-arm -M versatilepb -m 128M -nographic -s -S -kernel

.PHONY: qemu qgdb clean kill q g

q: chavear.bin
	make qemu
	sleep 1
	reset

g: chavear.elf
	make qgdb || make kill
	sleep 1
	make kill

qemu: chavear.bin kill
	$(qemu) chavear.bin

qgdb: chavear.elf
	arm-none-eabi-gdb -tui --command=.gdbrc -se chavear.elf

clean: kill
	rm -f *.o *.bin *.elf

kill:
	@pkill qemu && echo "interrompi o qemu" || echo "não rolou interromper o qemu"
	@pkill gdb && echo "interrompi o gdb" || echo "não rolou interromper o gdb"
	@pkill -9 qemu && echo "tive que MATAR o qemu" || true
	@pkill -9 gdb && echo "tive que MATAR o gdb" || true

print.o: print.c print.h
	$(eabi-gcc) print.c -o print.o

irq.o: irq.s
	$(eabi-as) irq.s -o irq.o

handler.o: handler.c print.h
	$(eabi-gcc) handler.c -o handler.o

tasks.o: tasks.c print.h
	$(eabi-gcc) tasks.c -o tasks.o

chavear.elf: tasks.o print.o handler.o irq.o
	$(eabi-ld) -T chavear.ld irq.o print.o handler.o tasks.o -o chavear.elf

chavear.bin: chavear.elf
	$(eabi-bin) chavear.elf chavear.bin

irq.elf: handler.o irqld.ld irq.o
	$(eabi-ld) -T irqld.ld irq.o handler.o -o irq.elf

irq.bin: irq.elf
	$(eabi-bin) irq.elf irq.bin
