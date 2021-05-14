//
// Created by flashie on 12.05.2021.
//
#include "assert.h"
#include "scalar_prod.h"

void c_scalar_prod(double *dst, const coords_t *src_a, const coords_t *src_b) {
    assert(src_a && src_b);
    *dst = src_a->x * src_b->x + src_a->y * src_b->y + src_a->z * src_b->z + src_a->w * src_b->w;
}

void print(coords_t *vec) {
    printf("[%lf %lf %lf %lf] ", vec->x, vec->y, vec->z, vec->w);
    puts("");
}

