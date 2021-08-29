# Build echoTyping program

objects = echoTyping.o
cflags = -g -c -Wall -masm=intel
asmflags = --gstabs

echoTyping: $(objects)
	gcc $ -o echoTyping $(objects)

echoTyping.o: echoTyping.s
	as $(asmflags) -o echoTyping.o echoTyping.s

.PHONY: clean allclean
clean:
	rm *~ *.o
allclean:
	rm *~ *.o echoTyping

