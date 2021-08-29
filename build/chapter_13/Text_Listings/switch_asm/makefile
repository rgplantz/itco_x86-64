# Build switch program

asflags = --gstabs
objects = switch.o

switch: $(objects)
	gcc -o switch switch.o

switch.o: switch.s
	as $(asflags) -o switch.o switch.s

.PHONY: clean allclean
clean:
	rm *~ *.o
	
allclean:
	rm *~ *.o switch 
	
