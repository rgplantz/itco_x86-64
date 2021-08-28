cFlags = -masm=intel -fno-asynchronous-unwind-tables -fcf-protection=none
asmFlags = --gstabs
objects = 

inches2feet: inches2feet.o
	gcc -o inches2feet inches2feet.o

inches2feet.o: inches2feet.c
	gcc $(cFlags) -c inches2feet.c

inches2feet.s: inches2feet.c
	gcc $(cFlags) -S inches2feet.c

clean:
	rm *~ *.o
	
allclean:
	rm *~ *.o inches2feet 
	
