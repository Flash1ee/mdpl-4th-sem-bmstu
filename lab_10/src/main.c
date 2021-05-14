#include <stdio.h>
#include "scalar_prod.h"

int main() {
    puts("TEST C IMPLEMENTATION");
    printf("%zu\n", sizeof(float));

    vector_t vec_a[3] = {{1, 1, 1, 1},
                         {2, 2, 2, 2},
                         {3, 3, 3, 3}};
    vector_t vec_b[3] = {{1, 1, 1,1},
                         {2, 2, 2,2},
                         {3, 3, 3,3}};

    for (size_t i = 0; i < 3; i++) {
        double res = 0.0;

        puts("INPUT VECTORS");
        printf("vec_a: ");
        print(&vec_a[i]);
        printf("vec_b: ");
        print(&vec_b[i]);

        c_scalar_prod(&res, &vec_a[i], &vec_b[i]);
        float res_sse=0.0;
        avx_scalar_prod(&res_sse, &vec_a[i], &vec_b[i]);

        puts("result: ");
        printf("%lf \n", res);
        printf("%lf \n", res_sse);




    }


    puts("Hello world!");
    return 0;
}