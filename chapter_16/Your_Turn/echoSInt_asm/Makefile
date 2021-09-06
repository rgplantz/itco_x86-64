# Makefile for echo program
# Bob Plantz - 2019_10_13

asmflags = --gstabs

# The object files are specific to this program.
objects = echoSInt.o readLn.o writeStr.o decToUInt.o decToSInt.o intToUDec.o intToSDec.o getInt.o putInt.o

echoSInt: $(objects)
	gcc -o echoSInt $(objects)

echoSInt.o: echoSInt.s
	as $(asmflags) -o echoSInt.o echoSInt.s

writeStr.o: writeStr.s
	as $(asmflags) -o writeStr.o writeStr.s

readLn.o: readLn.s
	as $(asmflags) -o readLn.o readLn.s

decToUInt.o: decToUInt.s
	as $(asmflags) -o decToUInt.o decToUInt.s

decToSInt.o: decToSInt.s
	as $(asmflags) -o decToSInt.o decToSInt.s

intToUDec.o: readLn.s
	as $(asmflags) -o intToUDec.o intToUDec.s

intToSDec.o: intToSDec.s
	as $(asmflags) -o intToSDec.o intToSDec.s

getInt.o: getInt.s
	as $(asmflags) -o getInt.o getInt.s

putInt.o: putInt.s
	as $(asmflags) -o putInt.o putInt.s

clean:
	rm $(objects) *~

allClean:
	rm $(objects) echoSInt *.o *~
