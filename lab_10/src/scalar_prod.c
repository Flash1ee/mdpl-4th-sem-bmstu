//
// Created by flashie on 12.05.2021.
//
#include "assert.h"
#include "scalar_prod.h"

void c_scalar_prod(double *dst, const vector_t *src_a, const vector_t *src_b) {
    assert(src_a && src_b);
    *dst = src_a->buf[0] * src_b->buf[0] + src_a->buf[1] * src_b->buf[1] + src_a->buf[2] * src_b->buf[2] +
           src_a->buf[3] * src_b->buf[3];
}

void avx_scalar_prod(float *dst, const vector_t *src_a, const vector_t *src_b) {
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

void print(vector_t *vec) {
    printf("[%lf %lf %lf %lf] ", vec->buf[0], vec->buf[1], vec->buf[2], vec->buf[3]);
    puts("");
}

