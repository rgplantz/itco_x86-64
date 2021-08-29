# Build endian program

objects = endian.o
cflags = -g -c -Wall -masm=intel
genasm = -S -Wall -masm=intel -fno-asynchronous-unwind-tables \
-fcf-protection=none

endian: $(objects)
	gcc $ -o endian $(objects)

endian.o: endian.c
	gcc $(cflags) endian.c

endian.s: endian.c
	gcc $(genasm) -o temp endian.c
	expand -t 8 temp > endian.s
	rm temp

.PHONY: clean allclean
clean:
	rm *~ *.o
allclean:
	rm *~ *.o endian

