# doNothingProg_att.s
# Minimum components of a C program, in assembly language.
        .text
        .globl  main
        .type   main, @function
main:
        push    %rbp        # save caller's frame pointer
        mov     %rsp, %rbp  # establish our frame pointer

        mov     $0, %rax    # return 0;

        mov     %rbp, %rsp  # restore stack pointer
        pop     %rbp        # restore caller's frame pointer
        ret                 # back to caller
