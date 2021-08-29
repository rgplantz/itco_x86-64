# Build coinFlipsEndsMid program

objects = coinFlipsEndsMid.o
cflags = -g -c -Wall -masm=intel
asmflags = --gstabs

coinFlipsEndsMid: $(objects)
	gcc $ -o coinFlipsEndsMid $(objects)

coinFlipsEndsMid.o: coinFlipsEndsMid.s
	as $(asmflags) -o coinFlipsEndsMid.o coinFlipsEndsMid.s

.PHONY: clean allclean
clean:
	rm *~ *.o
allclean:
	rm *~ *.o coinFlipsEndsMid

