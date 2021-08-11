/*#include "display.h"
#include "string.h"
#include "sp804.h"*/

#define TLOAD 0x0
#define TVALUE 0x1
#define TCNTL 0x2
#define TINTCLR 0x3
#define TRIS 0x4
#define TMIS 0x5
#define TBGLOAD 0x6
#define MAX_TIMER_NUMBER 4


typedef unsigned int u32;
typedef unsigned char u8;



typedef volatile struct timer
{
    u32 *base;            // timer's base address; as u32 pointer
    u32 tick, hh, mm, ss; // per timer data area
    u8 clock[16];
} TIMER;

volatile TIMER timer[MAX_TIMER_NUMBER];

u32 strcmp(u8 *s1, u8 *s2)
{
    while ((*s1++ == *s2++) && (*s1 != 0) && (*s2 != 0))
        ;
    if (*s1 == 0 && *s2 == 0)
    {
        return 0;
    }
    return 1;
}

u8* strcpy(u8 *s1, u8 *s2)
{
    while(*s2 != 0)
    {
        *s1++ = *s2++;
    }
    *s1 = '\0';
    return s1;
}

u32 strlen(const u8 *s)
{
    u32 i = 0;
    while (*s++ != '\0') i++;
    return i;
}

void timer_init_single(TIMER *tp, u32 base)
{
    //int i;
    //kprintf("timer_init_single()\n");
    tp->base = (u32 *)base;
    *(tp->base + TLOAD) = 0x0; // reset
    *(tp->base + TVALUE) = 0xFFFFFFFF;
    *(tp->base + TRIS) = 0x0;
    *(tp->base + TMIS) = 0x0;
    *(tp->base + TLOAD) = 0x100;
    // CntlReg=1110-0110=|En=1|Periodic=1|IntE=1|Rsvd=0|scal=01|1=32bit|0=wrap|=0xE6
    *(tp->base + TCNTL) = 0x66; // Bit 7 is started in timer_start() to enable the timer module, so the bit 7 should be set to 0 here.
    *(tp->base + TBGLOAD) = 0x1C00; // timer counter value
    tp->tick = tp->hh = tp->mm = tp->ss = 0; // initialize wall clock
    strcpy((u8 *)tp->clock, "00:00:00");    
}

// void timer_init()
// {
//     int i;
//     TIMER *tp;
//     kprintf("timer_init()\n");
//     for (i = 0; i < 4; i++)
//     {
//         tp = &timer[i];
//         switch(i)
//         {
//             case 0:
//                 tp->base = (u32 *)VERSATILEPB_SP804_TIMER0;
//                 break;
//             case 1:
//                 tp->base = (u32 *)VERSATILEPB_SP804_TIMER1;
//                 break;
//             case 2:
//                 tp->base = (u32 *)VERSATILEPB_SP804_TIMER2;
//                 break;
//             case 3:
//                 tp->base = (u32 *)VERSATILEPB_SP804_TIMER3;
//                 break;
//         }

//         *(tp->base + TLOAD) = 0x0; // reset
//         *(tp->base + TVALUE) = 0xFFFFFFFF;
//         *(tp->base + TRIS) = 0x0;
//         *(tp->base + TMIS) = 0x0;
//         *(tp->base + TLOAD) = 0x100;
//         // CntlReg=1110-0110=|En=1|Periodic=1|IntE=1|Rsvd=0|scal=01|1=32bit|0=wrap|=0xE6
//         *(tp->base + TCNTL) = 0x66; // Bit 7 is started in timer_start() to enable the timer module, so the bit 7 should be set to 0 here.
//         *(tp->base + TBGLOAD) = 0x1C00; // timer counter value
//         tp->tick = tp->hh = tp->mm = tp->ss = 0; // initialize wall clock
//         strcpy((u8 *)tp->clock, "00:00:00");
//     }
// }


void timer_start(u32 n) // timer_start(0), 1, etc.
{
    TIMER *tp = &timer[n];
    //kprintf("timer_start %d base=%x\n", n, tp->base);
    *(tp->base + TCNTL) |= 0x80; // set enable bit 7
}

void timer_stop(u32 n) // stop a timer
{
    TIMER *tp = &timer[n];
    *(tp->base + TCNTL) &= 0x7F; // clear enable bit 7
}

//u32 timer_clearInterrupt(u32 n) // timer_start(0), 1, etc.
void timer_clearInterrupt(u32 n) // timer_start(0), 1, etc.
{
    TIMER *tp = &timer[n];
    *(tp->base + TINTCLR) = 0xFFFFFFFF;
}

void timer_handler(u32 n)
{
    //u32 i;
    TIMER *t = &timer[n];
    t->tick++; // Assume 20 ticks per second. Need to calculate it for more accuracy.
    if (t->tick == 20)
    {
        t->tick = 0;
        t->ss++;
        if (t->ss == 60)
        {
            t->ss = 0;
            t->mm++;
            if (t->mm == 60)
            {
                t->mm = 0;
                t->hh++; // no 24 hour roll around
            }
        }
        t->clock[7] = '0' + (t->ss % 10);
        t->clock[6] = '0' + (t->ss / 10);
        t->clock[4] = '0' + (t->mm % 10);
        t->clock[3] = '0' + (t->mm / 10);
        t->clock[1] = '0' + (t->hh % 10);
        t->clock[0] = '0' + (t->hh / 10);
        //kprintf("Timer [%d]: %s\n", n, (u8 *)&t->clock[0]);
    }
    //color = n; // display in different color
    // for (i = 0; i < 8; i++)
    // {
    //     kpchar(t->clock[i], n, 70 + i); // to line n of LCD
    // }

    timer_clearInterrupt(n); // clear timer interrupt
}
int main(){
	return 0;
}
