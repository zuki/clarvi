#include "hello.h"

#define OUTPORT 0x00020004      //uart_tx
#define INPORT  0x00020000      //uart_rx


#define uart_status (*(volatile uint32_t*)0x00020008)

void trdy(void) {
    while(!(uart_status & 0x0040));
}

void rrdy(void) {
    while(!(uart_status & 0x0080));
}

char getchar() {
    rrdy();
    return *((volatile uint32_t*)INPORT);
}

void print_chr(char ch)
{
    trdy();
    *((volatile uint32_t*)OUTPORT) = ch;
}

void print_str(const char *p)
{
    while (*p != 0) {
        if(*p == '\n') {
            trdy();
            *((volatile uint32_t*)OUTPORT) = '\r';
        }
        trdy();
        *((volatile uint32_t*)OUTPORT) = *(p++);
    }
}

void print_hex(unsigned int val, int digits)
{
    for (int i = (4*digits)-4; i >= 0; i -= 4) {
        trdy();
        *((volatile uint32_t*)OUTPORT) = "0123456789ABCDEF"[(val >> i) % 16];
    }
}
