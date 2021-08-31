        .file   "threeFactorial.c"
        .intel_syntax noprefix
        .text
        .section        .rodata
.LC0:
        .string "%u! = %u\n"
        .text
        .globl  main
        .type   main, @function
main:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     DWORD PTR -8[rbp], 3
        mov     eax, DWORD PTR -8[rbp]
        mov     edi, eax
        call    factorial@PLT
        mov     DWORD PTR -4[rbp], eax
        mov     edx, DWORD PTR -4[rbp]
        mov     eax, DWORD PTR -8[rbp]
        mov     esi, eax
        lea     rdi, .LC0[rip]
        mov     eax, 0
        call    printf@PLT
        mov     eax, 0
        leave
        ret
        .size   main, .-main
        .ident  "GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
        .section        .note.GNU-stack,"",@progbits
