# Build echoChar program

objects = echoChar.o
cflags = -g -c -Wall -masm=intel
asmflags = --gstabs

echoChar: $(objects)
	gcc $ -o echoChar $(objects)

echoChar.o: echoChar.s
	as $(asmflags) -o echoChar.o echoChar.s

.PHONY: clean allclean
clean:
	rm *~ *.o
allclean:
	rm *~ *.o echoChar

