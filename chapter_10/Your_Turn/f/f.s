# f.s
# Minimum components of a C function, in assembly language.
        .intel_syntax noprefix
        .text
        .globl  f
        .type   f, @function
f:
        push    rbp         # save caller's frame pointer
        mov     rbp, rsp    # establish our frame pointer

        mov     eax, 0      # return 0;

        mov     rsp, rbp    # restore stack pointer
        pop     rbp         # restore caller's frame pointer
        ret                 # back to caller
