# Build test_chars program

objects = test_chars.o exclaim.o upperOh.o tilde.o
cflags = -g -c -Wall -masm=intel
asmflags = --gstabs

test_chars: $(objects)
	gcc $ -o test_chars $(objects)

test_chars.o: test_chars.c exclaim.h upperOh.h tilde.h
	gcc $(cflags) test_chars.c

exclaim.o: exclaim.s
	as $(asmflags) -o exclaim.o exclaim.s

upperOh.o: upperOh.s
	as $(asmflags) -o upperOh.o upperOh.s

tilde.o: tilde.s
	as $(asmflags) -o tilde.o tilde.s

.PHONY: clean allclean
clean:
	rm *~ *.o
allclean:
	rm *~ *.o test_chars

