//
// Created by flashie on 12.05.2021.
//
#include <time.h>
#include <float.h>
#include "assert.h"
#include "scalar_prod.h"

void c_scalar_prod(float *dst, const vector_t *src_a, const vector_t *src_b) {
    assert(src_a && src_b);
    *dst = src_a->buf[0] * src_b->buf[0] + src_a->buf[1] * src_b->buf[1] + src_a->buf[2] * src_b->buf[2] +
           src_a->buf[3] * src_b->buf[3];
}

void sse_scalar_prod(float *dst, const vector_t *src_a, const vector_t *src_b) {
    assert(src_a && src_b);
    __asm__(".intel_syntax noprefix\n\t"
            "movaps xmm0, %1\n\t"
            "movaps xmm1, %2\n\t"
            "mulps xmm0, xmm1\n\t"
            "movhlps xmm1, xmm0\n\t"
            "addps xmm0, xmm1\n\t"
            "movaps xmm1, xmm0\n\t"
            "shufps xmm0, xmm0, 1\n\t"
            "addps xmm0, xmm1\n\t"
            "movss %0, xmm0\n\t"
    :"=m"(*dst)
    :"m"(src_a->buf), "m"(src_b->buf)
    :"xmm0", "xmm1");
}

void execution_test(size_t count) {
//    float a = FLT_MAX;
//    float b = FLT_MAX;
//    float c = FLT_MAX;
    float a = 10.0;
    float b = 20.0;
    float c = 30.0;

    float res_c = 0;
    vector_t vec_a[3] = {a, b, c};
    vector_t vec_b[3] = {a, b, c};
    clock_t start = clock();
    puts("TEST C IMPLEMENTATION");
    for (size_t i = 0; i < count; i++) {
        c_scalar_prod(&res_c, vec_a, vec_b);
    }
    clock_t end_c = clock() - start;
    printf("C scalar multiply\n\t%.3g s\n", ((double) (end_c)) / CLOCKS_PER_SEC / (double) count);
    puts("TEST SSE ASSEMBLY");
    float res_asm = 0;
    start = clock();
    for (size_t i = 0; i < count; i++) {
        sse_scalar_prod(&res_asm, vec_a, vec_b);
    }
    clock_t end_asm = clock() - start;
    printf("SSE ASM scalar multiply\n\t%.3g s\n", ((double) (end_asm)) / CLOCKS_PER_SEC / (double) count);
    printf("LAST VALUES ARE EQUALS %d\n", res_asm==res_c);
    printf("C/ASM = %lf\n", (double)end_c/(double)end_asm);
}

void print(vector_t *vec) {
    printf("[%lf %lf %lf %lf] ", vec->buf[0], vec->buf[1], vec->buf[2], vec->buf[3]);
    puts("");
}

