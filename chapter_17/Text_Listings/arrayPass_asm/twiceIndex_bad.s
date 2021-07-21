# twiceIndex.s
# Stores 2 X element number in each array element.
# Calling sequence:
#   rdi <- pointer to array
#   esi <- number of elements
        .intel_syntax noprefix

# Code
        .text
        .globl  twiceIndex
        .type   twiceIndex, @function
twiceIndex:
        push    rbp         # save frame pointer
        mov     rbp, rsp    # set new frame pointer

        mov     ebx, 0      # index = 0
storeLoop:
        mov     eax, ebx    # current index
        shl     eax, 1      # times 2
        mov     [rdi+rbx*4], eax    # store result
        inc     ebx         # increment index
        cmp     ebx, esi    # end of array?
        jl      storeLoop   # no, loop back
        
        mov     rsp, rbp    # yes, restore stack pointer
        pop     rbp         # and caller frame pointer
        ret

