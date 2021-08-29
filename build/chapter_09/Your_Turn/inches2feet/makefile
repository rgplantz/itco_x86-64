# Build inches2feet program

objects = inches2feet.o
cflags = -g -c -Wall -masm=intel
genasm = -S -Wall -masm=intel -fno-asynchronous-unwind-tables \
-fcf-protection=none

inches2feet: $(objects)
	gcc $ -o inches2feet $(objects)

inches2feet.o: inches2feet.c
	gcc $(cflags) inches2feet.c

inches2feet.s: inches2feet.c
	gcc $(genasm) -o temp inches2feet.c
	expand -t 8 temp > inches2feet.s
	rm temp

.PHONY: clean allclean
clean:
	rm *~ *.o
allclean:
	rm *~ *.o inches2feet

