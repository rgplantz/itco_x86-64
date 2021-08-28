# Build doNothingProg program

objects = doNothingProg.o
asmflags = --gstabs

doNothingProg: $(objects)
	gcc $ -o doNothingProg $(objects)

doNothingProg.o: doNothingProg.s
	as $(asmflags) -o doNothingProg.o doNothingProg.s

.PHONY: clean allclean
clean:
	rm *~ *.o
allclean:
	rm *~ *.o doNothingProg

