# Build helloWorld-for program

objects = helloWorld-for.o
cflags = -O0 -Wall -masm=intel -g
genasm = -O0 -Wall -masm=intel -fno-asynchronous-unwind-tables \
-fcf-protection=none

helloWorld: $(objects)
	gcc -o helloWorld $(objects)

helloWorld-for.o: helloWorld-for.c
	gcc -c $(cflags) helloWorld-for.c

helloWorld-for.s: helloWorld-for.c
	gcc -S $(genasm) -o temp helloWorld-for.c
	expand -t 8 temp > helloWorld-for.s
	rm temp

.PHONY: clean allclean
clean:
	rm *~ *.o

allclean:
	rm *~ *.o helloWorld
