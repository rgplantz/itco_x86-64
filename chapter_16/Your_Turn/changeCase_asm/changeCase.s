# changeCase.s
# Switches the case of user alphabetic text string
        .intel_syntax noprefix
# Stack frame
        .equ    myString,-64
        .equ    canary,-8
        .equ    localSize,-64
# Useful constants
        .equ    MAX,50  # character buffer limit
        .equ    NUL,0
# Constant data
        .section	.rodata
        .align 8
prompt:
        .string	"Enter up to 50 alphabetic characters: "
message:
        .string	"Opposite case: "
newLine:
        .string	"\n"
# Code
        .text
        .globl	main
        .type	main, @function
main:
        push    rbp         # save frame pointer
        mov     rbp, rsp    # set new frame pointer
        add     rsp, localSize  # for local var.
        mov     rax, qword ptr fs:40    # get canary
        mov     qword ptr canary[rbp], rax

        lea     rdi, prompt[rip]    # prompt user
        call    writeStr
        
        mov     esi, MAX    # limit user input
        lea     rdi, myString[rbp]  # place to store input
        call    readLn

        lea     rsi, myString[rbp]  # destination string
        lea     rdi, myString[rbp]  # source string
        call    change
        
        lea     rdi, message[rip]   # tell user
        call    writeStr

        lea     rdi, myString[rbp]  # result
        call    writeStr
        lea     rdi, newLine[rip]   # some formatting
        call    writeStr

        mov     eax, 0      # return 0;
        mov     rcx, qword ptr canary[rbp]
        xor     rcx, qword ptr fs:40
        je      allOK
        call    __stack_chk_fail@plt
allOK:
        mov     rsp, rbp    # restore stack pointer
        pop     rbp         # and caller frame pointer
        ret

