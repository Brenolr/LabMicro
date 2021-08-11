int v[] = {1,2,3,4,5,6,7,8,9,10};
int sum;

#define TXFE 0x80
#define TXFF 0x20
#define RXFE 0x10
#define RXFF 0x40
#define BUSY 0x08

#define UDR 0x00
#define UFR 0x18
#define TLOAD 0x0
#define TVALUE 0x1
#define TCNTL 0x2
#define TINTCLR 0x3
#define TRIS 0x4
#define TMIS 0x5
#define TBGLOAD 0x6
#define MAX_TIMER_NUMBER 4
#define VERSATILEPB_SP804_TIMER0 0x101E2000


typedef unsigned int u32;
typedef unsigned char u8;



typedef volatile struct timer
{
    u32 *base;            // timer's base address; as u32 pointer
    u32 tick, hh, mm, ss; // per timer data area
    u8 clock[16];
} TIMER;

volatile TIMER timer[MAX_TIMER_NUMBER];

typedef volatile struct uart {
    char *base;
    int n;
}UART;

UART uart[4];

void uart_init()
{
    int i;
    UART *up;
    for(i=0; i<4; i++){
        up = &uart[i];
        up->base = (char *)(0x101F1000 + i*0x1000);
        up->n = i;
    }
    uart[3].base = (char *)(0x10009000);
}


char ugetc(UART *up)
{
    while(*(up->base + UFR) & RXFE);
    return *(up->base + UDR);
}

void uputc(UART *up, char c)
{
    while(*(up->base + UFR) & TXFF);
    *(up->base + UDR) = c;
}

void upgets(UART *up, char *s)
{
    while((*s = ugetc(up))!='\r'){
        uputc(up, *s);
        s++;
    }
    *s = 0;
}

void uprints(UART *up, char *s)
{
    while(*s)
    {
        uputc(up, *s++);
    }
}

int strcmp(char *s1, char *s2)
{
    while((*s1++==*s2++)&&(*s1!=0)&&(*s2!=0));
    if(*s1==0 && *s2==0)
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

//timer
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
    //sssstrcpy((u8 *)tp->clock, "00:00:00");    
}

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
	timer_clearInterrupt(n);
}


int main()
{
    int i;
	u32 h,m,s;
	int segs;
    char string[64];
    UART *up;
	TIMER *tp = &timer[0];
	timer_init_single(tp, VERSATILEPB_SP804_TIMER0);
    uart_init();
    up = &uart[0];
	timer_start(0);
    uprints(up, "\n\rEnter lines from serial terminal 0\n\r");

    while(1){
        upgets(up, string);
        uprints(up, "   ");
        uprints(up, string);
        uprints(up, "\n\r");
        if(strcmp(string, "end")==0){
            break;
        }        
    }
	//stimer_stop(0);
	h = tp->hh;
	m = tp->mm;
	s = tp->ss;
	segs =  3600*h + 60*m + s;
    uprints(up, "Compute sum of array:\n\r");
    sum = 0;
    for(i=0; i<10; i++){
        sum += v[i];
    }

    uprints(up, "sum = ");
    uputc(up, (sum/10)+'0');
    uputc(up, (sum%10)+'0');
	uprints(up, "Compute sum of array:\n\r");
	uprints(up, "h:");
	uputc(up, (h/10)+'0');
    uputc(up, (h%10)+'0');
	uprints(up, " m:");
	uputc(up, (m/10)+'0');
    uputc(up, (m%10)+'0');
	uprints(up, " s:");
	uputc(up, (s/10)+'0');
    uputc(up, (s%10)+'0');
    uprints(up, "\n\rEND OF RUN\n\r");
	return 0;
}
