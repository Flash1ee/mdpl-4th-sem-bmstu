//
// Created by flashie on 08.05.2021.
//

#include "processing.h"


float sum_32_bit_nums(float a, float b) {
    return a + b;
}

float mul_32_bit_nums(float a, float b) {
    return a * b;
}

float asm_sum_32_bit_nums(float a, float b) {
    float res = 0;
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

float asm_mul_32_bit_nums(float a, float b) {
    float res = 0;
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

void print_32_bit_result() {
    float a = 10e+12;
    float b = 10e-12;
    clock_t beg_sum = clock();
    for (int i = 0; i < COUNT; i++) {
        sum_32_bit_nums(a, b);
    }
    clock_t end_sum = (clock() - beg_sum);
    printf("Clock time for %d trying sum processing %.3g\n", COUNT, (double) end_sum / CLOCKS_PER_SEC / (double) COUNT);


    clock_t beg_mul = clock();
    for (int i = 0; i < COUNT; i++) {
        mul_32_bit_nums(a, b);
    }
    clock_t end_mul = (clock() - beg_mul);
    printf("Clock time for %d mul processing %.3g\n", COUNT, (double) end_mul / CLOCKS_PER_SEC / (double) COUNT);

}
void asm_print_32_bit_result() {
    puts("ASSEMBLY INSERTION");
    float a = 10e+3;
    float b = 10e-3;

    clock_t beg_sum = clock();
    for (int i = 0; i < COUNT; i++) {
        asm_sum_32_bit_nums(a, b);
    }
    clock_t end_sum = (clock() - beg_sum);
    printf("Clock time for %d trying sum processing %.3g\n", COUNT, (double) end_sum / CLOCKS_PER_SEC / (double) COUNT);

    clock_t beg_mul = clock();
    for (int i = 0; i < COUNT; i++) {
        asm_mul_32_bit_nums(a, b);
    }
    clock_t end_mul = (clock() - beg_mul);
    printf("Clock time for %d mul processing %.3g\n", COUNT, (double) end_mul / CLOCKS_PER_SEC / (double) COUNT);
}

