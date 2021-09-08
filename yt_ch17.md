---
layout: default
title: Chapter 17
---

## Chapter 17

### Page 380
1. The register indirect with indexing addressing mode makes it very simple for us to store a value at any location in an array. We need to add only two instructions in the `main` function to solve this problem. They are added right after the call to `twiceIndex`.
 
    ```asm
    # arrayFifth.s
    # Allocates an int array, stores 2 X element number
    # in each element, then stores 123 in fifth element.
            .intel_syntax noprefix
    # Stack frame
            .equ    intArray,-48
            .equ    canary,-8
            .equ    localSize,-48
    # Constant
            .equ    N,10
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

            mov     esi, N      # number of elements
            lea     rdi, intArray[rbp]   # our array
            call    twiceIndex

            mov     rcx, 4      # fifth element
            mov     dword ptr [rdi+rcx*4], 123  # store 123 there

            mov     esi, N      # number of elements
            lea     rdi, intArray[rbp]   # our array
            call    displayArray
            
            mov     eax, 0      # return 0;
            mov     rcx, qword ptr canary[rbp]
            xor     rcx, qword ptr fs:40
            je      allOK
            call    __stack_chk_fail@plt
    allOK:
            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # and caller frame pointer
            ret
    ```

2. As you might expect, the compiler does not use the sign extension instruction, `cdqe`, because the index value is unsigned. In the `twiceIndex` function, it replaces the code sequence:

    ```asm
        mov     eax, DWORD PTR -4[rbp]
        cdqe                            ## to 64 bits
        lea     rdx, 0[0+rax*4]         ## element offset
        mov     rax, QWORD PTR -24[rbp] ## array address
        add     rax, rdx                ## element address
        mov     edx, DWORD PTR -4[rbp]  ## current i
        add     edx, edx                ## 2 x i
        mov     DWORD PTR [rax], edx    ## store 2 X i
    ```

   with:

    ```asm
        mov     eax, DWORD PTR -4[rbp]  ## load i
        lea     edx, [rax+rax]          ## 2 x i
        mov     eax, DWORD PTR -4[rbp]  ## load i
        lea     rcx, 0[0+rax*4]         ## element offset
        mov     rax, QWORD PTR -24[rbp] ## array address
        add     rax, rcx                ## element address
        mov     DWORD PTR [rax], edx
    ```
   Notice that the compiler uses `lea     edx, [rax+rax]` to compute two times the index instead of using an `add` instruction. Despite the name, load effective address, the `lea` instruction adds the contents of the two registers specified (it's the same register here, `eax`) and stores that sum in the destination register. The values do not need to be used as addresses in the program.


### Page 393
1. The effects of this change are easiest to see in the `displayRecord` function. The version in Listing 17-18 copies the twelve bytes that make up the record that is passed to it by value (my comments follow ##):

    ```asm
            mov     QWORD PTR -16[rbp], rdx ## 8 bytes of record
            mov     DWORD PTR -8[rbp], eax  ## another 4 bytes
            movzx   eax, BYTE PTR -8[rbp]   ## load anotherChar
            movsx   ecx, al                 ## extend to 32 bits
            mov     edx, DWORD PTR -12[rbp] ## load anInt
            movzx   eax, BYTE PTR -16[rbp]  ## load aChar
            movsx   eax, al                 ## extend to 32 bits
    ```

   But placing the two `char` elements adjacent to each other reduces the size of the record from twelve to eight bytes:

    ```asm
            mov     QWORD PTR -8[rbp], rdi  ## 8 bytes of record
            movzx   eax, BYTE PTR -7[rbp]   ## load anotherChar
            movsx   ecx, al                 ## extend to 32 bits
            mov     edx, DWORD PTR -4[rbp]  ## load anInt
            movzx   eax, BYTE PTR -8[rbp]   ## load aChar
            movsx   eax, al                 ## extend to 32 bits
    ```

   We can verify the placement of the value in the record using `gdb`:

    ```
    (gdb) l displayRecord
    4	
    5	#include <stdio.h>
    6	#include "displayRecord.h"
    7	
    8	void displayRecord(struct aTag aRecord)
    9	{
    10	  printf("%c, %i, %c\n", aRecord.aChar,
    11	         aRecord.anInt, aRecord.anotherChar);
    12	}
    13	
    (gdb) b 10
    Breakpoint 1 at 0x1240: file displayRecord.c, line 10.
    (gdb) r
    Starting program: /home/bob/chapter_17/Your_Turn/recordPassAdj_C/records 

    Breakpoint 1, displayRecord (aRecord=...) at displayRecord.c:10
    10	  printf("%c, %i, %c\n", aRecord.aChar,
    (gdb) i r rbp
    rbp            0x7fffffffde60      0x7fffffffde60
    (gdb) x/8xb 0x7fffffffde58
    0x7fffffffde58:	0x61	0x62	0x55	0x55	0x7b	0x00	0x00	0x00
    ```

   Here we see `aChar` at location `0x7fffffffde58`, `anotherChar` at `0x7fffffffde59`, and `anInt` at `0x7fffffffde5c` (in little endian order). The two bytes at `0x7fffffffde5a` and `0x7fffffffde5b` are garbage values.

    ```
    (gdb) c
    Continuing.
    a, 123, b

    Breakpoint 1, displayRecord (aRecord=...) at displayRecord.c:10
    10	  printf("%c, %i, %c\n", aRecord.aChar,
    (gdb) x/8xb 0x7fffffffde58
    0x7fffffffde58:	0x31	0x32	0xff	0xff	0xc8	0x01	0x00	0x00
    (gdb) c
    Continuing.
    1, 456, 2
    [Inferior 1 (process 3155) exited normally]
    (gdb) 
    ```

   And when `displayRecord` is called with `y`, we see its values stored at the same locations.

2. When we pass by pointer, `displayRecord` loads the data from the calling function's copy of the record rather than make its own copy. As usual, I've added my own comments (##) to the compiler's assembly language to explain things.

    ```asm
            .file   "displayRecord.c"
            .intel_syntax noprefix
            .text
            .section        .rodata
    .LC0:
            .string "%c, %i, %c\n"
            .text
            .globl  displayRecord
            .type   displayRecord, @function
    displayRecord:
            push    rbp
            mov     rbp, rsp
            sub     rsp, 16
            mov     QWORD PTR -8[rbp], rdi  ## save address of record
            mov     rax, QWORD PTR -8[rbp]  ## load address of record
            movzx   eax, BYTE PTR 8[rax]    ## load anotherChar
            movsx   ecx, al                 ## extend to 32 bits
            mov     rax, QWORD PTR -8[rbp]  ## load address of record
            mov     edx, DWORD PTR 4[rax]   ## load anInt
            mov     rax, QWORD PTR -8[rbp]  ## load address of record
            movzx   eax, BYTE PTR [rax]     ## load aChar
            movsx   eax, al                 ## extend to 32 bits
            mov     esi, eax
            lea     rdi, .LC0[rip]
            mov     eax, 0
            call    printf@PLT
            nop
            leave
            ret
            .size   displayRecord, .-displayRecord
            .ident  "GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
            .section        .note.GNU-stack,"",@progbits
    ```

