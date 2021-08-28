# Build test_f program

objects = test_f.o f.o
cflags = -g -c -Wall -masm=intel
asmflags = --gstabs

test_f: $(objects)
	gcc $ -o test_f $(objects)

test_f.o: test_f.c f.h
	gcc $(cflags) test_f.c

f.o: f.s
	as $(asmflags) -o f.o f.s

.PHONY: clean allclean
clean:
	rm *~ *.o
allclean:
	rm *~ *.o test_f

