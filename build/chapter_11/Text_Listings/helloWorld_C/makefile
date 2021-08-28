# Build helloWorld program

objects = helloWorld.o
cflags = -g -c -Wall -masm=intel
genasm = -S -Wall -masm=intel -fno-asynchronous-unwind-tables \
-fcf-protection=none

helloWorld: $(objects)
	gcc $ -o helloWorld $(objects)

helloWorld.o: helloWorld.c
	gcc $(cflags) helloWorld.c

helloWorld.s: helloWorld.c
	gcc $(genasm) -o temp helloWorld.c
	expand -t 8 temp > helloWorld.s
	rm temp

.PHONY: clean allclean
clean:
	rm *~ *.o
allclean:
	rm *~ *.o helloWorld

