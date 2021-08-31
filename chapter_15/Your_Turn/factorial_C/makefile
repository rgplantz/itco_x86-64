# Build factorial program

objects = threeFactorial.o factorial.o
cflags = -O0 -Wall -masm=intel -g
genasm = -O0 -Wall -masm=intel -fno-asynchronous-unwind-tables \
-fcf-protection=none

factorial: $(objects)
	gcc -o threeFactorial $(objects)

threeFactorial.o: threeFactorial.c factorial.h
	gcc -c $(cflags) threeFactorial.c

factorial.o: factorial.c
	gcc -c $(cflags) factorial.c

factorial.s: factorial.c
	gcc -S $(genasm) -o temp factorial.c
	expand -t 8 temp > factorial.s
	rm temp

threeFactorial.s: threeFactorial.c factorial.h
	gcc -S $(genasm) -o temp threeFactorial.c
	expand -t 8 temp > threeFactorial.s
	rm temp

.PHONY: clean allclean
clean:
	rm *~ *.o

allclean:
	rm *~ *.o threeFactorial
