---
layout: default
title: Chapter 10
---

## Chapter 10

### Page 216
1. The program doesn't change `rsp` after the first instruction pushes `rbp`, so this instruction doesn't change the values in any registers. TUI only highlights changes.
   
   Changing the exit value to 123 gave me `Inferior 1 (process 4891) exited with code 0173]` when `gdb` ended execution of the program. A number beginning with `0` in `gdb` means that it's in octal: `173`<sub>8</sub> = 123<sub>10</sub>

2. It broke at the first {. I couldn't see what was going on in either the prologue or the epilogue. `gdb` only shows the source code, which is in C.
3. 
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
    We also need a header fiile so we can call this function in C.
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
4. 
    ```c
    /* test_ints.c
     * Tests three functions that return ints.
     */

    #include <stdio.h>
    #include "twelve.h"
    #include "thirtyFour.h"
    #include "fiftySix.h"

    int main(void)
    {
      int return1, return2, return3;

      return1 = twelve();
      return2 = thirtyFour();
      return3 = fiftySix();
      printf("The returned ints are: %i, %i, and %i.\n",
            return1, return2, return3);

      return 0;
    }
    ```
    ```c
    /* twelve.h
     * Returns 12
     */

    #ifndef TWELVE_H
    #define TWELVE_H
    int twelve(void);
    #endif
    ```
    ```asm
    # twelve.s
    # Returns twelve.
            .intel_syntax noprefix
            .text
            .globl  twelve
            .type   twelve, @function
    twelve:
            push    rbp         # save caller's frame pointer
            mov     rbp, rsp    # establish our frame pointer

            mov     eax, 12     # return 12;

            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # restore caller's frame pointer
            ret                 # back to caller
    ```
    ```c
    /* thirtyFour.h
     * Returns 34
     */

    #ifndef THIRTYFOUR_H
    #define THIRTYFOUR_H
    int thirtyFour(void);
    #endif
    ```
    ```asm
    # thirtyFour.s
    # Returns 34.
          .intel_syntax noprefix
          .text
          .globl  thirtyFour
          .type   thirtyFour, @function
    thirtyFour:
          push    rbp         # save caller's frame pointer
          mov     rbp, rsp    # establish our frame pointer

          mov     eax, 34     # return 34;

          mov     rsp, rbp    # restore stack pointer
          pop     rbp         # restore caller's frame pointer
          ret                 # back to caller
    ```
    ```c
    /* fiftySix.h
     * Returns 56
     */

    #ifndef FIFTYSIX_H
    #define FIFTYSIX_H
    int fiftySix(void);
    #endif
    ```
    ```asm
    # fiftySix.s
    # Returns 56.
            .intel_syntax noprefix
            .text
            .globl  fiftySix
            .type   fiftySix, @function
    fiftySix:
            push    rbp         # save caller's frame pointer
            mov     rbp, rsp    # establish our frame pointer

            mov     eax, 56     # return 56;

            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # restore caller's frame pointer
            ret                 # back to caller
    ```
5. 
    ```c
    /* test_chars.c
     * Tests three functions that return chars.
     */

    #include <stdio.h>
    #include "exclaim.h"
    #include "upperOh.h"
    #include "tilde.h"

    int main(void)
    {
      char return1, return2, return3;

      return1 = exclaim();
      return2 = upperOh();
      return3 = tilde();
      printf("The returned chars are: %c, %c, and %c.\n",
            return1, return2, return3);

      return 0;
    }
    ```
    ```c
    /* exclaim.h
     * Returns '!'
     */

    #ifndef EXCLAIM_H
    #define EXCLAIM_H
    char exclaim(void);
    #endif

    ```
    ```asm
    # exclaim.s
    # Returns '!'.
            .intel_syntax noprefix
            .text
            .globl  exclaim
            .type   exclaim, @function
    exclaim:
            push    rbp         # save caller's frame pointer
            mov     rbp, rsp    # establish our frame pointer

            mov     eax, '!'    # return '!';

            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # restore caller's frame pointer
            ret                 # back to caller
    ```
    ```c
    /* upperOh.h
     * Returns 'O'
     */

    #ifndef UPPEROH_H
    #define UPPEROH_H
    char upperOh(void);
    #endif
    ```
    ```asm
    # upperOh.s
    # Returns 'O'.
            .intel_syntax noprefix
            .text
            .globl  upperOh
            .type   upperOh, @function
    upperOh:
            push    rbp         # save caller's frame pointer
            mov     rbp, rsp    # establish our frame pointer

            mov     eax, 'O'    # return 'O';

            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # restore caller's frame pointer
            ret                 # back to caller
    ```
    ```c
    /* tilde.h
     * Returns '~'
     */

    #ifndef TILDE_H
    #define TILDE_H
    char tilde(void);
    #endif

    ```
    ```asm
    # tilde.s
    # Returns '~'.
            .intel_syntax noprefix
            .text
            .globl  tilde
            .type   tilde, @function
    tilde:
            push    rbp         # save caller's frame pointer
            mov     rbp, rsp    # establish our frame pointer

            mov     eax, '~'    # return '~';

            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # restore caller's frame pointer
            ret                 # back to caller
    ```

