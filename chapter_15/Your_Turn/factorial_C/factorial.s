        .file   "factorial.c"
        .intel_syntax noprefix
        .text
        .globl  factorial
        .type   factorial, @function
factorial:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        mov     DWORD PTR -20[rbp], edi
        mov     DWORD PTR -4[rbp], 1
        cmp     DWORD PTR -20[rbp], 0
        je      .L2
        mov     eax, DWORD PTR -20[rbp]
        sub     eax, 1
        mov     edi, eax
        call    factorial
        mov     edx, DWORD PTR -20[rbp]
        imul    eax, edx
        mov     DWORD PTR -4[rbp], eax
.L2:
        mov     eax, DWORD PTR -4[rbp]
        leave
        ret
        .size   factorial, .-factorial
        .ident  "GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
        .section        .note.GNU-stack,"",@progbits
