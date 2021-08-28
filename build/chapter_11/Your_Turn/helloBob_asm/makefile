# Build helloWorld program

objects = helloWorld.o
asmflags = --gstabs

helloWorld: $(objects)
	gcc $ -o helloWorld $(objects)

helloWorld.o: helloWorld.s
	as $(asmflags) -o helloWorld.o helloWorld.s

.PHONY: clean allclean
clean:
	rm *~ *.o
allclean:
	rm *~ *.o helloWorld

