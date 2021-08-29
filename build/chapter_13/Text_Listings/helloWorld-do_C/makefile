# Build helloWorld-do program

objects = helloWorld-do.o
cflags = -O0 -Wall -masm=intel -g
genasm = -O0 -Wall -masm=intel -fno-asynchronous-unwind-tables \
-fcf-protection=none

helloWorld: $(objects)
	gcc -o helloWorld $(objects)

helloWorld-do.o: helloWorld-do.c
	gcc -c $(cflags) helloWorld-do.c

helloWorld-do.s: helloWorld-do.c
	gcc -S $(genasm) -o temp helloWorld-do.c
	expand -t 8 temp > helloWorld-do.s
	rm temp

.PHONY: clean allclean
clean:
	rm *~ *.o

allclean:
	rm *~ *.o helloWorld
