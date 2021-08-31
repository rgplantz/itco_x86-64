        .file   "factorial.c"
        .intel_syntax noprefix
        .text
        .globl  factorial
        .type   factorial, @function
factorial:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        mov     DWORD PTR -20[rbp], edi ## store n
        mov     DWORD PTR -4[rbp], 1    ## current = 1;
        cmp     DWORD PTR -20[rbp], 0   ## base case?
        je      .L2                     ## yes, current good
        mov     eax, DWORD PTR -20[rbp] ## no, compute n-1
        sub     eax, 1
        mov     edi, eax
        call    factorial               ## compute (n-1)!
        mov     edx, DWORD PTR -20[rbp] ## load n 
        imul    eax, edx                ## n * (n-1)!
        mov     DWORD PTR -4[rbp], eax  ## store in current
.L2:
        mov     eax, DWORD PTR -4[rbp]  ## load current
        leave
        ret
        .size   factorial, .-factorial
        .ident  "GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
        .section        .note.GNU-stack,"",@progbits
