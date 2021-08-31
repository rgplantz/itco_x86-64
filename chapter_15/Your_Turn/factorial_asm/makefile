# Build factorial program

objects = threeFactorial.o factorial.o
cflags = -g -c -Wall -masm=intel
asmflags = --gstabs

factorial: $(objects)
	gcc -o threeFactorial $(objects)

threeFactorial.o: threeFactorial.c factorial.h
	gcc $(cflags) threeFactorial.c

factorial.o: factorial.s
	as $(asmflags) -o factorial.o factorial.s

.PHONY: clean allclean
clean:
	rm *~ *.o

allclean:
	rm *~ *.o threeFactorial
