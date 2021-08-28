# Create listing files


listingflags = --gstabs -al

addressing.lst: addressing.s
	as $(listingflags) -o addressing.o addressing.s > addressing.lst

immediate.lst: immediate.s
	as $(listingflags) -o immediate.o immediate.s > immediate.lst

jumps.lst: jumps.s
	as $(listingflags) -o jumps.o jumps.s > jumps.lst

memory.lst: memory.s
	as $(listingflags) -o memory.o memory.s > memory.lst

register.lst: register.s
	as $(listingflags) -o register.o register.s > register.lst

.PHONY: clean
clean:
	rm *~ *.o

