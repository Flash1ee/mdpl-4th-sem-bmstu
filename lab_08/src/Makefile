CC=g++
FLAGS=-Wall -O0 -masm=intel

run:
	$(CC) $(FLAGS) -o $@ main.cpp
	./$@

disassembly:
	$(CC) $(FLAGS) -S -o dis.s main.cpp
	cat dis.s

clean:
	rm -rf *.o *.s *.out
