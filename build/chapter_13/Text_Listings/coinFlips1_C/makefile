# Build coinFlips1 program

objects = coinFlips1.o
cflags = -O0 -Wall -masm=intel -g
genasm = -O0 -Wall -masm=intel -fno-asynchronous-unwind-tables \
-fcf-protection=none

coinFlips1: $(objects)
	gcc -o coinFlips1 $(objects)

coinFlips1.o: coinFlips1.c
	gcc -c $(cflags) coinFlips1.c

coinFlips1.s: coinFlips1.c
	gcc -S $(genasm) -o temp coinFlips1.c
	expand -t 8 temp > coinFlips1.s
	rm temp

.PHONY: clean allclean
clean:
	rm *~ *.o

allclean:
	rm *~ *.o coinFlips1
