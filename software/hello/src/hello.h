#ifndef HELLO_H
#define HELLO_H

#include <stdint.h>

char getchar(void);
void print_chr(char ch);
void print_str(const char *p);
void print_hex(unsigned int val, int digits);
#endif
