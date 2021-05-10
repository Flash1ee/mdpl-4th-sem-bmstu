//
// Created by flashie on 10.05.2021.
//

#include "processing.h"

#ifndef X87
long double sum_80_bit_nums(long double a, long double b) {
    return a + b;
}

long double mul_80_bit_nums(long double a, long double b) {
    return a * b;
}

long double asm_sum_80_bit_nums(long double a, long double b) {
    long double res = 0;
    __asm__(".intel_syntax noprefix\n\t"
            "fld %1\n\t"
            "fld %2\n\t"
            "faddp\n\t"
            "fstp %0\n\t"
    : "=&m"(res)
    : "m"(a),"m"(b)
    );
    return res;
}

long double asm_mul_80_bit_nums(long double a, long double b) {
    long double res = 0;
    __asm__(".intel_syntax noprefix\n\t"
            "fld %1\n\t"
            "fld %2\n\t"
            "fmulp\n\t"
            "fstp %0\n\t"
    : "=&m"(res)
    : "m"(a),"m"(b)
    );
    return res;

}

void print_80_bit_result() {
    long double a = 10e+12;
    long double b = 10e-12;
    clock_t beg_sum = clock();
    for (int i = 0; i < COUNT; i++) {
        sum_80_bit_nums(a, b);
    }
    clock_t end_sum = (clock() - beg_sum);
    printf("Clock time for %d trying sum processing %.3Lg\n", COUNT, (long double) end_sum / CLOCKS_PER_SEC / (long double) COUNT);


    clock_t beg_mul = clock();
    for (int i = 0; i < COUNT; i++) {
        mul_80_bit_nums(a, b);
    }
    clock_t end_mul = (clock() - beg_mul);
    printf("Clock time for %d mul processing %.3Lg\n", COUNT, (long double) end_mul / CLOCKS_PER_SEC / (long double) COUNT);

}
void asm_print_80_bit_result() {
    puts("ASSEMBLY INSERTION");
    long double a = 10e+12;
    long double b = 10e-12;

    clock_t beg_sum = clock();
    for (int i = 0; i < COUNT; i++) {
        asm_sum_80_bit_nums(a, b);
    }
    clock_t end_sum = (clock() - beg_sum);
    printf("Clock time for %d trying sum processing %.3Lg\n", COUNT, (long double) end_sum / CLOCKS_PER_SEC / (long double) COUNT);

    clock_t beg_mul = clock();
    for (int i = 0; i < COUNT; i++) {
        asm_mul_80_bit_nums(a, b);
    }
    clock_t end_mul = (clock() - beg_mul);
    printf("Clock time for %d mul processing %.3Lg\n", COUNT, (long double) end_mul / CLOCKS_PER_SEC / (long double) COUNT);
}
#endif

