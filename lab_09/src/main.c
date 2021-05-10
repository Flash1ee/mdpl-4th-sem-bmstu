#include <stdio.h>
#include "processing.h"

int main() {
    puts("32 bit - float");
    print_32_bit_result();
    asm_print_32_bit_result();
    puts("");
    puts("64 bit - double");
    print_64_bit_result();
    asm_print_64_bit_result();
#ifndef X87
    puts("");
    puts("80 bit - double");
    print_80_bit_result();
    asm_print_80_bit_result();
#endif
    printf("Hello world!\n");
    return 0;
}