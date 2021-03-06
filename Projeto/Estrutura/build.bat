arm-none-eabi-as -mcpu=arm926ej-s ts.S -o build/ts.o
arm-none-eabi-gcc -mcpu=arm926ej-s -marm -g -c timer.c -o build/timer.o
arm-none-eabi-gcc -mcpu=arm926ej-s -marm -g -c t.c -o build/t.o
arm-none-eabi-gcc -mcpu=arm926ej-s -marm -g -c uart.c -o build/uart.o

arm-none-eabi-ld build/ts.o build/t.o build/timer.o build/uart.o  -T t.ld -o build/t.elf

arm-none-eabi-objcopy -O binary build/t.elf build/t.bin
