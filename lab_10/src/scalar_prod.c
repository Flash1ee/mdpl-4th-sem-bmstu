//
// Created by flashie on 12.05.2021.
//
#include "assert.h"
#include "scalar_prod.h"


void c_scalar_prod(double *dst, const double *src_a, const double *src_b, size_t n) {
    assert(dst && src_a && src_b);
    assert(n > 0);
    for (size_t i = 0; i < n; ++i) {
        *dst++ = *src_a++ * *src_b++;
    }
}

