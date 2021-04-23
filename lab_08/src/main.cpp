#include <iostream>
#include <cstring>

/* Первая принимает 1 параметр - указатель на строку, определяет длину строки и
выполнена в виде ассемблерной вставки;
 вторая копирует строку с адреса, заданного одним указателем, по адресу,
заданному другим указателем, и реализована в отдельном asm-файле. Функция
должна принимать 3 параметра: два указателя и длину строки. Прорасположение указателей в памяти и расстояние между ними заранее ничего не
известно (первая строка может начинаться раньше второй или наоборот; строки
могут перекрываться).
*/
int my_strlen(const char *str) {
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

int main() {

    const char *msg = "Hello world!";
    int len = my_strlen(msg);
    std::cout << "lenght string Calc ASM " << len << " real len " << strlen(msg) << std::endl;


    return 0;
}