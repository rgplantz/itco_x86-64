# Build dec2Hex program

dec2Hex: dec2Hex.o
	gcc -o dec2Hex dec2Hex.o

dec2Hex.o: dec2Hex.c
	gcc -c -g -Wall -masm=intel dec2Hex.c

.PHONY: clean allclean
clean:
	rm *~ *.o
allclean:
	rm *~ *.o dec2Hex

