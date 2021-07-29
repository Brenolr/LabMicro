#include "defines.h"
#include "string.c"
#define printf kprintf
char *tab = "0123456789ABCDEF";
#include "uart.c"
#include "kbd.c"
#include "timer.c"
#include "vid.c"
#include "exceptions.c"
#include "sdc.c"
void copy_vectors(void)
{ // same as before }
    void IRQ_handler()
    {
        int vicstatus, sicstatus;
        int ustatus, kstatus;
        // read VIC SIV status registers to find out which interrupt
        vicstatus = VIC_STATUS;
        sicstatus = SIC_STATUS;
        // VIC status BITs: timer0=4, uart0=13, uart1=14, SIC=31: KBD at 3
        if (vicstatus & (1 << 4))
        { // bit 4: timer0
            timer_handler(0);
        }
        if (vicstatus & (1 << 12))
        { // Bit 12: UART0
            uart_handler(&uart[0]);
        }
        if (vicstatus & (1 << 13))
        { // bit 13: UART1
            uart_handler(&uart[1]);
        }
        if (vicstatus & (1 << 31))
        { // SIC interrupts=bit_31 on VIC
            if (sicstatus & (1 << 3))
            { // KBD at IRQ3 of SIC
                kbd_handler();
            }
            if (sicstatus & (1 << 22))
            { // SDC at IRQ22 of SIC
                sdc_handler();
            }
        }
    }
    char rbuf[512], wbuf[512];
    char *line[2] = {"THIS IS A TEST LINE", "this is a test line"};
    int main()
    {
        int i, sector, N;
        fbuf_init();
        kbd_init();
        uart_init();
        /* enable timer0,1, uart0,1 SIC interrupts */
        VIC_INTENABLE = (1 << 4);   // timer0,1 at bit4
        VIC_INTENABLE |= (1 << 12); // UART0 at bit12
        VIC_INTENABLE |= (1 << 13); // UART1 at bit13
        VIC_INTENABLE |= (1 << 31); // SIC to VIC's IRQ31
        /* enable KBD and SDC IRQ */
        SIC_INTENABLE = (1 << 3);   // KBD int=bit3 on SIC
        SIC_INTENABLE |= (1 << 22); // SDC int=bit22 on SIC
        SIC_ENSET = (1 << 3);       // KBD int=3 on SIC
        SIC_ENSET |= (1 << 22);     // SDC int=22 on SIC
        timer_init();
        timer_start(0);
        /* Code for testing UART and KBD drivers are omitted */
        printf("test SDC DRIVER\n");
        sdc_init();
        N = 1; // Write|Read N sectors of SDC
        for (sector = 0; sector < N; sector++)
        {
            printf("WRITE sector %d: ", sector);
            memset(wbuf, ' ', 512);  // blank out wbuf
            for (i = 0; i < 12; i++) // write lines to wbuf
                strcpy(wbuf + i * 40, line[sector % 2]);
            put_sector(sector, wbuf);
        }
        printf("\n");
        for (sector = 0; sector < N; sector++)
        {
            printf("READ sector %d\n", sector);
            get_sector(sector, rbuf);
            for (i = 0; i < 512; i++)
            {
                printf("%c", rbuf[i]);
            }
            printf("\n");
        }
        printf("in while(1) loop: enter keys from KBD or UART\n");
        while (1)
            ;
    }