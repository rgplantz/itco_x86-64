# Build sumInts program

objects = doNothingProg.o
cflags = -g -c -Wall -masm=intel
genasm = -S -Wall -masm=intel -fno-asynchronous-unwind-tables \
-fcf-protection=none
genasm_part = -S -Wall -masm=intel -fno-asynchronous-unwind-tables
genasm_full = -S -Wall -masm=intel

doNothingProg: $(objects)
	gcc $ -o doNothingProg $(objects)

doNothingProg.o: doNothingProg.c
	gcc $(cflags) doNothingProg.c

doNothingProg.s: doNothingProg.c
	gcc $(genasm) -o temp doNothingProg.c
	expand -t 8 temp > doNothingProg.s
	rm temp

doNothingProg_part.s: doNothingProg.c
	gcc $(genasm_part) -o temp doNothingProg.c
	expand -t 8 temp > doNothingProg_part.s
	rm temp

doNothingProg_full.s: doNothingProg.c
	gcc $(genasm_full) -o temp doNothingProg.c
	expand -t 8 temp > doNothingProg_full.s
	rm temp

.PHONY: clean allclean
clean:
	rm *~ *.o
allclean:
	rm *~ *.o doNothingProg

