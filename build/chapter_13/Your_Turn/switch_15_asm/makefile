# Build switch_15 program

asflags = --gstabs
objects = switch_15.o

switch_15: $(objects)
	gcc -o switch_15 switch_15.o

switch_15.o: switch_15.s
	as $(asflags) -o switch_15.o switch_15.s

.PHONY: clean allclean
clean:
	rm *~ *.o
	
allclean:
	rm *~ *.o switch_15 
	
