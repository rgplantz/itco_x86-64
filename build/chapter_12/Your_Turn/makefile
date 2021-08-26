# Create listing files


listingflags = --gstabs -al

constToMemory.lst: constToMemory.s
	as $(listingflags) -o constToMemory.o constToMemory.s > constToMemory.lst

regToMemory.lst: regToMemory.s
	as $(listingflags) -o regToMemory.o regToMemory.s > regToMemory.lst

register_change.lst: register_change.s
	as $(listingflags) -o register_change.o register_change.s > register_change.lst

.PHONY: clean
clean:
	rm *~ *.o

