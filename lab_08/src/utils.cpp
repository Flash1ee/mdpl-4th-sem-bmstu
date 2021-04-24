#include "utils.h"

int my_strlen(char *str) {
    int len = 0;
    __asm__(
    ".intel_syntax noprefix\n\t"
    "mov ecx, 65536\n\t"
    "mov al, 0\n\t"
    "mov rdi, %1\n\t"
    "repne scasb\n\t"
    "mov edx, 65536\n\t"
    "sub edx, ecx\n\t"
    "dec edx\n\t"
    "mov %0, edx\n\t"
    :"=r"(len)
    :"r"(str)
    :"%ecx", "%edi", "%al", "%edx"
    );
    return len;
}