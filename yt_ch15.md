---
layout: default
title: Chapter 15
---

## Chapter 15

### Page 326
1.  I got the following. Your numbers may differ.

    ```
    (gdb) l factorial
    1       /* factorial.c
    2        */
    3       #include "factorial.h"
    4
    5       unsigned int factorial(unsigned int n)
    6       {
    7         unsigned int current = 1; /* assume base case */
    8         if (n != 0)
    9           current = n * factorial(n - 1);
    10        return current;
    (gdb) b 9
    Breakpoint 1 at 0x11a5: file factorial.c, line 9.
    (gdb) r
    Starting program: /home/bob/GitHub/itco_x86-64/chapter_15/Your_Turn/factorial_C/threeFactorial 

    Breakpoint 1, factorial (n=3) at factorial.c:9
    9           current = n * factorial(n - 1);
    (gdb) print n
    $1 = 3
    (gdb) c
    Continuing.

    Breakpoint 1, factorial (n=2) at factorial.c:9
    9           current = n * factorial(n - 1);
    (gdb) c
    Continuing.

    Breakpoint 1, factorial (n=1) at factorial.c:9
    9           current = n * factorial(n - 1);
    (gdb) print n
    $2 = 1
    (gdb) i r rsp
    rsp            0x7fffffffd970      0x7fffffffd970
    (gdb) x/6gx 0x7fffffffd970
    0x7fffffffd970: 0x0000000000000000      0x00000001ffffef71
    0x7fffffffd980: 0x0000000000000000      0x0000000100000000
    0x7fffffffd990: 0x00007fffffffd9c0      0x00005555555551b2
    (gdb) x/6gx 0x7fffffffd9a0
    0x7fffffffd9a0: 0x0000000000000000      0x0000000200000000
    0x7fffffffd9b0: 0x0000555555554040      0x0000000100f0b2e4
    0x7fffffffd9c0: 0x00007fffffffd9f0      0x00005555555551b2
    (gdb) x/6gx 0x7fffffffd9d0
    0x7fffffffd9d0: 0x00007fffffffd9f6      0x000000035555520d
    0x7fffffffd9e0: 0x00007ffff7fbdfc8      0x00000001555551c0
    0x7fffffffd9f0: 0x00007fffffffda10      0x0000555555555166
    (gdb) 
    ```
    From the assembly language in Listing 15-4 we see that each stack frame is 48 bytes, 8 for the return address, 8 for saving the caller's `rbp`, and 32 for the local variables in `factorial`. So I display 6 giant (64-bit) numbers in hex for each of the three stack frames. We can see the value of `n` in each stack frame by looking at the first 32 bits in the values at `0x7fffffffd97c`, `0x7fffffffd9ac`, and `0x7fffffffd9dc`. (Reminder: This is a little endian computer.) Notice that the return addresses in the stack frames for n = 1 and n = 2 (the top two in this display) are the same: `0x00005555555551b2`. This is the return address to the `factorial` subfunction, showing that it's called recursively.

### Page 334
1.  Look for CF.

    ```c
    /* sumUInts.c
     * Adds two unsigned integers
     */

    #include <stdio.h>
    #include "addTwoCF.h"

    int main(void)
    {
      unsigned int x = 0, y = 0, z, carry;
      
      printf("Enter an integer: ");
      scanf("%u", &x);
      printf("Enter an integer: ");
      scanf("%u", &y);
      carry = addTwoCF(x, y, &z);
      printf("%u + %u = %u\n", x, y, z);
      if (carry)
        printf("*** Carry occurred ***\n");

      return 0;
    }
    ```
    ```c
    /* addTwoCF.h
    * Adds two unsigned integers and determines carry.
    */

    #ifndef ADDTWOCF_H
    #define ADDTWOCF_H
    int addTwoCF(unsigned int a, unsigned int b, unsigned int *c);
    #endif
    ```
    ```asm
    # addTwoCF.s
    # Adds two unsigned integers and returns CF
    # Calling sequence:
    #       edi <- x, 32-bit unsigned int
    #       esi <- y, 32-bit unisgned int
    #       rdx <- &z, place to store sum
    #       returns value of CF
            .intel_syntax noprefix

    # Code
            .text
            .globl  addTwoCF
            .type   addTwoCF, @function
    addTwoCF:
            push    rbp         # save frame pointer
            mov     rbp, rsp    # set new frame pointer

            add     edi, esi    # x + y
            setc    al          # CF T or F
            movzx   eax, al     # convert to int
            mov     [rdx] , edi # *c = sum
            
            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # and caller frame pointer
            ret
    ```

2.  z

    ```c
    /* sumUInts.c
    * Adds two unsigned integers
    */

    #include <stdio.h>

    int main(void)
    {
      unsigned int x = 0, y = 0, z, carry;
      
      printf("Enter an integer: ");
      scanf("%u", &x);
      printf("Enter an integer: ");
      scanf("%u", &y);

      asm("mov edi, %2\n"
          "add edi, %3\n"
          "setc al\n"
          "movzx eax, al\n"
          "mov %1, eax\n"
          "mov %0, edi"
          : "=rm" (z), "=rm" (overflow)
          : "rm" (x), "rm" (y)
          : "rax", "rdx", "cc");

      printf("%u + %u = %u\n", x, y, z);
      if (carry)
        printf("*** Carry occurred ***\n");

      return 0;
    }
    ```

