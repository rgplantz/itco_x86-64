# Build coinFlips2 program

asflags = --gstabs
objects = coinFlips2.o

coinFlips2: $(objects)
	gcc -o coinFlips2 coinFlips2.o

coinFlips2.o: coinFlips2.s
	as $(asflags) -o coinFlips2.o coinFlips2.s

.PHONY: clean allclean
clean:
	rm *~ *.o
	
allclean:
	rm *~ *.o coinFlips2 
	
