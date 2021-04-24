#include <iostream>
#include <cstring>
#include <cassert>
#include "utils.h"

#define N 64

extern "C" {
void my_strcpy(char *dest, char *msg, int len);

}

int main() {
    char msg[] = "Hello world!";
    size_t len = my_strlen(msg);

    assert(len == strlen(msg));

    std::cout << "USAGE my_strlen with str " << msg << std::endl;
    std::cout << "lenght string Calc ASM " << len << " real len " << strlen(msg) << std::endl;

    std::cout << std::endl;
    char dest[N] = {};
    std::cout << "Source string is " << msg << " len " << my_strlen(msg) << std::endl;
    std::cout << "Destination string before copy " << dest << " len " << my_strlen(dest) << std::endl;
    std::cout << std::endl;

    my_strcpy(dest, msg, strlen(msg));

    assert(!strcmp(dest, msg));

    std::cout << "Source string after copy " << msg << " len " << my_strlen(msg) << std::endl;
    std::cout << "Destination string after copy " << dest << " len " << my_strlen(dest) << std::endl;

    return 0;
}