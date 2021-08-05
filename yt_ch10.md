---
layout: default
title: Chapter 10
---

## Chapter 10

### Page aa
1. The program doesn't change `rsp` after the first instruction pushes `rbp`, so this instruction doesn't change the values in any registers. TUI only highlights changes.
   
   Changing the exit value to 123 gave me `Inferior 1 (process 4891) exited with code 0173]` when `gdb` ended execution of the program. A number beginning with `0` in `gdb` means that it's in octal: `173`<sub>8</sub> = 123<sub>10</sub>

2. 
   ```asm
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
   ```
   We also need a header fiile so we can call this function in C
   ```c
   /* f.h
   * Returns 0
   */

   #ifndef F_H
   #define F_H
   int f(void);
   #endif
   ```
   And here's a simple C function to display the return value.
   ```c
   /* test_f.c
   * Tests f() function.
   */

   #include <stdio.h>
   #include "f.h"

   int main(void)
   {
   int returnValue;
   returnValue = f();
   printf("f returned %i.\n", returnValue);

   return 0;
   }
   ```
3. yyy
   * a
   * b
   * c
   * d
4. zzz
   * a
   * b
   * c
   * d

