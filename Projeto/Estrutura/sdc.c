/*********** sdc.c ARM PL180 SDC driver **********/
#include "sdc.h"
#include <stdint.h>
typedef uint32_t u32;


u32 base;

#define printf kprintf
int delay()
{
    int i;
    for (i = 0; i < 100; i++){

    }
}
int do_command(int cmd, int arg, int resp)
{
    *(u32 *)(base + ARGUMENT) = (u32)arg;
    *(u32 *)(base + COMMAND) = 0x400 | (resp << 6) | cmd;
    delay();
}
int sdc_init()
{
    u32 RCA = (u32)0x45670000; // QEMU's hard-coded RCA
    base = (u32)0x10005000;    // PL180 base address
    printf("sdc_init : ");
    *(u32 *)(base + POWER) = (u32)0xBF; // power on
    *(u32 *)(base + CLOCK) = (u32)0xC6; // default CLK
    // send init command sequence
    do_command(0, 0, MMC_RSP_NONE);  // idle state
    do_command(55, 0, MMC_RSP_R1);   // ready state
    do_command(41, 1, MMC_RSP_R3);   // argument must not be zero
    do_command(2, 0, MMC_RSP_R2);    // ask card CID
    do_command(3, RCA, MMC_RSP_R1);  // assign RCA
    do_command(7, RCA, MMC_RSP_R1);  // transfer state: must use RCA
    do_command(16, 512, MMC_RSP_R1); // set data block length
    // set interrupt MASK0 registers bits = RxAvail|TxEmpty
    *(u32 *)(base + MASK0) = (1 << 21) | (1 << 18); //0x00240000;
    printf("done\n");
}
// shared variables between SDC driver and interrupt handler
volatile char *rxbuf, *txbuf;
volatile int rxcount, txcount, rxdone, txdone;
int sdc_handler()
{
    u32 status, err;
    int i;
    u32 *up;
    // read status register to find out RxDataAvail or TxBufEmpty
    status = *(u32 *)(base + STATUS);
    if (status & (1 << 21))
    { // RxDataAvail: read data
        printf("SDC RX interrupt: ");
        up = (u32 *)rxbuf;
        err = status & (DCRCFAIL | DTIMEOUT | RXOVERR);
        while (!err && rxcount)
        {
            printf("R%d ", rxcount);
            *(up) = *(u32 *)(base + FIFO);
            up++;
            rxcount -= sizeof(u32);
            status = *(u32 *)(base + STATUS);
            err = status & (DCRCFAIL | DTIMEOUT | RXOVERR);
        }
        rxdone = 1;
    }
    else if (status & (1 << 18))
    { // TxBufEmpty: send data
        printf("SDC TX interrupt: ");
        up = (u32 *)txbuf;
        status_err = status & (DCRCFAIL | DTIMEOUT);
        while (!status_err && txcount)
        {
            printf("W%d ", txcount);
            *(u32 *)(base + FIFO) = *up;
            up++;
            txcount -= sizeof(u32);
            status = *(u32 *)(base + STATUS);
            status_err = status & (DCRCFAIL | DTIMEOUT);
        }
        txdone = 1;
    }
    //printf("write to clear register\n");
    *(u32 *)(base + STATUS_CLEAR) = 0xFFFFFFFF;
    printf("SDC interrupt handler return\n");
}
int get_sector(int sector, char *buf)
{
    u32 cmd, arg;
    //printf("get_sector %d %x\n", sector, buf);
    rxbuf = buf;
    rxcount = 512;
    rxdone = 0;
    *(u32 *)(base + DATATIMER) = 0xFFFF0000;
    // write data_len to datalength reg
    *(u32 *)(base + DATALENGTH) = 512;
    //printf("dataControl=%x\n", 0x93);
    // 0x93=|9|0011|=|9|DMA=0,0=BLOCK,1=Host<-Card,1=Enable
    *(u32 *)(base + DATACTRL) = 0x93;
    cmd = 17; // CMD17 = READ single block
    arg = (sector * 512);
    do_command(cmd, arg, MMC_RSP_R1);
    while (rxdone == 0)
        ;
    printf("get_sector return\n");
}
int put_sector(int sector, char *buf)
{
    u32 cmd, arg;
    //printf("put_sector %d %x\n", sector, buf);
    txbuf = buf;
    txcount = 512;
    txdone = 0;
    *(u32 *)(base + DATATIMER) = 0xFFFF0000;
    *(u32 *)(base + DATALENGTH) = 512;
    cmd = 24; // CMD24 = Write single block
    arg = (u32)(sector * 512);
    do_command(cmd, arg, MMC_RSP_R1);
    //printf("dataControl=%x\n", 0x91);
    // 0x91=|9|0001|=|9|DMA=0,BLOCK=0,0=Host->Card,1=Enable
    *(u32 *)(base + DATACTRL) = 0x91; // Host->card
    while (txdone == 0)
        ;
    printf("put_sector return\n");
}