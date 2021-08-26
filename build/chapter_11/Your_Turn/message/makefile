# Build message program

objects = message.o theMessage.o
cflags = -g -c -Wall -masm=intel
asmflags = --gstabs
genasm = -S -Wall -masm=intel -fno-asynchronous-unwind-tables \
-fcf-protection=none

message: $(objects)
	gcc -o message $(objects)

message.o: message.s
	as $(asmflags) -o message.o message.s

theMessage.o: theMessage.c
	gcc $(cflags) theMessage.c

.PHONY: clean allclean
clean:
	rm *~ *.o
allclean:
	rm *~ *.o message

