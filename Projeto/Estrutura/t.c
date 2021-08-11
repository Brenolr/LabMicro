#include "types.h"
#include "versatilepb_pl190_vic.h"
#include "uart.h"
#include "vid.h"
#include "timer.h"
#define VERSATILEPB_SP804_TIMER0 0x101E2000
int sum;
int v[] = {1,2,3,4,5,6,7,8,9,10};

extern UART uart[4];
extern void uart_handler(UART *up);

extern void uprints(UART *up, u8 *s);
extern void ugets(UART *up, char *s);

extern TIMER timer[4];
//extern void timer_init_single(TIMER *tp, u32 base);

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
void upgets(UART *up, char *s)
{
    while((*s = ugetc(up))!='\r'){
        uputc(up, *s);
        s++;
    }
    *s = 0;
}

int div(int a, int b){

    int r=0;

    while(a>=b){
        a=a-b;
        r++;
    }
    return(r);

}
void main()
{
    int i,segs,wpm;
    u8 *p;
    char string[64];
    UART *up;

	u32 h,m,s;
	TIMER *tp = &timer[0];
    VIC_INTENABLE |= UART0_IRQ_VIC_BIT;
    VIC_INTENABLE |= TIMER0_IRQ_VIC_BIT;

    uart_init();
    timer_init_single(tp, VERSATILEPB_SP804_TIMER0);
    
    up= &uart[0];

    timer_start(0);
    uprints(up, "\n\rEnter lines from serial terminal 0\n\r");

    u8 c = '0';
    while(1)
    {

        upgets(up, string);
        uprints(up, "   ");
        uprints(up, string);
        uprints(up, "\n\r");
        if(strcmp(string, "end")==0){
            break;
        }  
    }

    timer_stop(0);
	h = tp->hh;
	m = tp->mm;
	s = tp->ss;
	segs =  60*m + s;
    uprints(up, "Compute sum of array:\n\r");
    sum = 0;
    for(i=0; i<10; i++){
        sum += v[i];
    }

    wpm = div(sum, (int)segs);
    uprints(up, "sum = ");
    uputc(up, (sum/10)+'0');
    uputc(up, (sum%10)+'0');
	uprints(up, "\n\rExecution Time:\n\r");
	uprints(up, "h:");
	uputc(up, (h/10)+'0');
    uputc(up, (h%10)+'0');
	uprints(up, " m:");
	uputc(up, (m/10)+'0');
    uputc(up, (m%10)+'0');
	uprints(up, " s:");
	uputc(up, (s/10)+'0');
    uputc(up, (s%10)+'0');
    
    uprints(up, "\n\rAverage typing speed:\n\r");
    uputc(up, ((int)wpm/100)+'0');
    uputc(up, ((int)wpm/10)+'0');
    uprints(up, ",");
    uputc(up, ((int)wpm%10)+'0');
    uprints(up, "\n\rEND OF RUN\n\r");
}

void copy_vectors()
{
    extern u32 vectors_start, vectors_end;
    u32 *vectors_src = &vectors_start;
    u32 *vectors_dst = (u32 *)0;
    while(vectors_src < &vectors_end)
    {
        *vectors_dst++ = *vectors_src++;
    }
}

void IRQ_handler()
{
    u32 vicstatus = VIC_STATUS;
    //UART 0
    if(vicstatus & UART0_IRQ_VIC_BIT)
    {
        
        uart_handler(&uart[0]);
    }

    if(vicstatus & TIMER0_IRQ_VIC_BIT)
    {
        timer_handler(0);
    }

}
