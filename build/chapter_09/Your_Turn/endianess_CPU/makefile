# Build endianReg program

objects = endianReg.o
cflags = -g -c -Wall -masm=intel
genasm = -S -Wall -masm=intel -fno-asynchronous-unwind-tables \
-fcf-protection=none

endianReg: $(objects)
	gcc $ -o endianReg $(objects)

endianReg.o: endianReg.c
	gcc $(cflags) endianReg.c

endianReg.s: endianReg.c
	gcc $(genasm) -o temp endianReg.c
	expand -t 8 temp > endianReg.s
	rm temp

.PHONY: clean allclean
clean:
	rm *~ *.o
allclean:
	rm *~ *.o endianReg

