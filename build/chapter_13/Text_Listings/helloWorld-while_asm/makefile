cFlags = -masm=intel -fno-asynchronous-unwind-tables -fcf-protection=none
asmFlags = --gstabs
objects = 

helloWorld: helloWorld.o
	gcc -o helloWorld helloWorld.o

helloWorld.o: helloWorld.s
	as $(asmFlags) -o helloWorld.o helloWorld.s

clean:
	rm *~ *.o
	
allclean:
	rm *~ *.o helloWorld 
	
