# Build helloWorld program

objects = helloWorld.o
cflags = -O0 -Wall -masm=intel -g
genasm = -O0 -Wall -masm=intel -fno-asynchronous-unwind-tables \
-fcf-protection=none

helloWorld: $(objects)
	gcc -o helloWorld $(objects)

helloWorld.o: helloWorld.c
	gcc -c $(cflags) helloWorld.c

helloWorld.s: helloWorld.c
	gcc -S $(genasm) -o temp helloWorld.c
	expand -t 8 temp > helloWorld.s
	rm temp

.PHONY: clean allclean
clean:
	rm *~ *.o

allclean:
	rm *~ *.o helloWorld
