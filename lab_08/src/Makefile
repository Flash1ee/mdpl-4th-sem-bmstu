CC=g++
FLAGS=-Wall -O0 -masm=intel
INC=../inc/
UTILS=utils.cpp
SOURCE=main.cpp
ASM_FUNC=copy.asm

build:
	nasm -f elf64 -o copy.o $(ASM_FUNC)
	$(CC) $(FLAGS) -I$(INC) -c $(UTILS)
	$(CC) -I$(INC) -c $(SOURCE)
	$(CC) -o run utils.o copy.o main.o

run: build
	./$@


disassembly:
	$(CC) $(FLAGS) -I$(INC) -S -o dis.s $(SOURCE)
	cat dis.s

clean:
	rm -rf *.o *.s *.out run