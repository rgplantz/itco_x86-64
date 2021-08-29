# Build test_ints program

objects = test_ints.o twelve.o thirtyFour.o fiftySix.o
cflags = -g -c -Wall -masm=intel
asmflags = --gstabs

test_ints: $(objects)
	gcc $ -o test_ints $(objects)

test_ints.o: test_ints.c twelve.h thirtyFour.h fiftySix.h
	gcc $(cflags) test_ints.c

twelve.o: twelve.s
	as $(asmflags) -o twelve.o twelve.s

thirtyFour.o: thirtyFour.s
	as $(asmflags) -o thirtyFour.o thirtyFour.s

fiftySix.o: fiftySix.s
	as $(asmflags) -o fiftySix.o fiftySix.s

.PHONY: clean allclean
clean:
	rm *~ *.o
allclean:
	rm *~ *.o test_ints

