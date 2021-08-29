# Build hex2Dec program

hex2Dec: hex2Dec.o
	gcc -o hex2Dec hex2Dec.o

hex2Dec.o: hex2Dec.c
	gcc -c -g -Wall -masm=intel hex2Dec.c

.PHONY: clean allclean
clean:
	rm *~ *.o
allclean:
	rm *~ *.o hex2Dec

