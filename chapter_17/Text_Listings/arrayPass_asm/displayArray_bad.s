# displayArray.s
# Prints array contents.
# Calling sequence:
#   rdi <- pointer to array
#   esi <- number of elements
        .intel_syntax noprefix

# Constant data
        .section	.rodata
        .align 8
format1:
        .string	"intArray["
format2:
        .string	"] = "
endl:
        .string "\n"
# Code
        .text
        .globl  displayArray
        .type   displayArray, @function
displayArray:
        push    rbp         # save frame pointer
        mov     rbp, rsp    # set new frame pointer

        mov     r12, rdi    # r12 and r13 are preserved
        mov     r13d, esi   #    when functions are called
        
        mov     ebx, 0      # index = 0
printLoop:
        lea     rdi, format1[rip]   # start of formatting
        call    writeStr
        mov     edi, ebx    # index
        call    putInt
        lea     rdi, format2[rip]   # more formatting
        call    writeStr
        mov     edi, [r12+rbx*4]    # array element
        call    putInt  # print on screen
        lea     rdi, endl[rip]  # next line
        call    writeStr

        inc     ebx         # increment index
        cmp     ebx, r13d   # end of array?
        jl      printLoop   # no, loop back
        
        mov     rsp, rbp    # yes, restore stack pointer
        pop     rbp         # and caller frame pointer
        ret

