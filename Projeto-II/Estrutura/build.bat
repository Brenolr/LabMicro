

arm-none-eabi-gcc -mcpu=arm926ej-s -marm -g -c full.c -o build/t.o
arm-none-eabi-gcc -mcpu=arm926ej-s -mthumb -g -c full.c -o build/t_thumb.o

arm-none-eabi-gcc -mcpu=arm926ej-s -mthumb -S full.c -o t_thumb.S
arm-none-eabi-gcc -mcpu=arm926ej-s -marm -S full.c -o t_arm.S

arm-none-eabi-as -mcpu=arm926ej-s ts.S -o build/ts.o

arm-none-eabi-ld build/ts.o build/t.o -T t.ld -o build/t.elf

arm-none-eabi-objcopy -O binary build/t.elf build/t.bin
