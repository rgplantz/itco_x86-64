# Build switch program

objects = switch.o
cflags = -O0 -Wall -masm=intel -g
genasm = -O0 -Wall -masm=intel -fno-asynchronous-unwind-tables \
-fcf-protection=none

switch: $(objects)
	gcc -o switch $(objects)

switch.o: switch.c
	gcc -c $(cflags) switch.c

switch.s: switch.c
	gcc -S $(genasm) -o temp switch.c
	expand -t 8 temp > switch.s
	rm temp

.PHONY: clean allclean
clean:
	rm *~ *.o

allclean:
	rm *~ *.o switch
