# Build echoChar program

objects = echoChar.o
cflags = -g -c -Wall -masm=intel
genasm = -S -Wall -masm=intel -fno-asynchronous-unwind-tables \
-fcf-protection=none

echoChar: $(objects)
	gcc $ -o echoChar $(objects)

echoChar.o: echoChar.c
	gcc $(cflags) echoChar.c

echoChar.s: echoChar.c
	gcc $(genasm) -o temp echoChar.c
	expand -t 8 temp > echoChar.s
	rm temp

.PHONY: clean allclean
clean:
	rm *~ *.o
allclean:
	rm *~ *.o echoChar

