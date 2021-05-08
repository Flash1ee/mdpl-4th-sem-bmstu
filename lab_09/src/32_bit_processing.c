#include <stdio.h>
#include <time.h>
#include "32_bit_processing.h"


float sum_32_bit_nums(float a, float b) {
    return a + b;
}

float mul_32_bit_nums(float a, float b) {
    return a * b;
}

void print_32_bit_result() {
    float a = 10e+3;
    float b = 10e-3;
    clock_t beg_sum = clock();
    for (int i = 0; i < COUNT; i++) {
        sum_32_bit_nums(a, b);
    }
    clock_t end_sum = (clock() - beg_sum);
    printf("Clock time for %d sum processing %.3g\n", COUNT, (double) end_sum / CLOCKS_PER_SEC / (double) COUNT);


    clock_t beg_mul = clock();
    for (int i = 0; i < COUNT; i++) {
        mul_32_bit_nums(a, b);
    }
    clock_t end_mul = (clock() - beg_mul);
    printf("Clock time for %d mul processing %.3g\n", COUNT, (double) end_mul / CLOCKS_PER_SEC / (double) COUNT);

}

