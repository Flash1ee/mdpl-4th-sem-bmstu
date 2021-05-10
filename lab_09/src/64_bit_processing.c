//
// Created by flashie on 10.05.2021.
//

#include "processing.h"


double sum_64_bit_nums(double a, double b) {
    return a + b;
}

double mul_64_bit_nums(double a, double b) {
    return a * b;
}

double asm_sum_64_bit_nums(double a, double b) {
    double res = 0;
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

double asm_mul_64_bit_nums(double a, double b) {
    double res = 0;
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

void print_64_bit_result() {
    double a = 10e+12;
    double b = 10e-12;
    clock_t beg_sum = clock();
    for (int i = 0; i < COUNT; i++) {
        sum_64_bit_nums(a, b);
    }
    clock_t end_sum = (clock() - beg_sum);
    printf("Clock time for %d trying sum processing %.3g\n", COUNT, (double) end_sum / CLOCKS_PER_SEC / (double) COUNT);


    clock_t beg_mul = clock();
    for (int i = 0; i < COUNT; i++) {
        mul_64_bit_nums(a, b);
    }
    clock_t end_mul = (clock() - beg_mul);
    printf("Clock time for %d mul processing %.3g\n", COUNT, (double) end_mul / CLOCKS_PER_SEC / (double) COUNT);

}
void asm_print_64_bit_result() {
    puts("ASSEMBLY INSERTION");
    double a = 10e+12;
    double b = 10e-12;

    clock_t beg_sum = clock();
    for (int i = 0; i < COUNT; i++) {
        asm_sum_64_bit_nums(a, b);
    }
    clock_t end_sum = (clock() - beg_sum);
    printf("Clock time for %d trying sum processing %.3g\n", COUNT, (double) end_sum / CLOCKS_PER_SEC / (double) COUNT);

    clock_t beg_mul = clock();
    for (int i = 0; i < COUNT; i++) {
        asm_mul_64_bit_nums(a, b);
    }
    clock_t end_mul = (clock() - beg_mul);
    printf("Clock time for %d mul processing %.3g\n", COUNT, (double) end_mul / CLOCKS_PER_SEC / (double) COUNT);




}

