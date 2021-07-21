# recordField.s
# Allocates a record and assigns a value to each field.
        .intel_syntax noprefix
# Stack frame
        .equ    x,-12
        .equ    localSize,-16
# record offsets
        .equ    aChar,0
        .equ    anInt,4
        .equ    anotherChar,8
        .equ    recordSize,12
# Constant data
        .section	.rodata
        .align 8
message:
        .string	"x: %c, %i, %c\n"
# Code
        .text
        .globl	main
        .type	main, @function
main:
        push    rbp         # save frame pointer
        mov     rbp, rsp    # set new frame pointer
        add     rsp, localSize  # for local var.

        lea     rbx, x[rbp]     # fill record
        mov     byte ptr aChar[rbx], 'a'
        mov     dword ptr anInt[rbx], 123
        mov     byte ptr anotherChar[rbx], 'c'
        
        lea     rbx, x[rbp]     # print record
        movzx   ecx, byte ptr aChar[rbx]
        mov     edx, dword ptr anInt[rbx]
        movzx   esi, byte ptr anotherChar[rbx]
        lea     rdi, message[rip]
        mov     eax, 0
        call    printf@plt

        mov     eax, 0      # return 0;
        mov     rsp, rbp    # restore stack pointer
        pop     rbp         # and caller frame pointer
        ret

