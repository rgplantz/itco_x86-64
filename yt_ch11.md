---
layout: default
title: Chapter 11
---

## Chapter 11

### Page 241
1. The operating system reads characters as you type them on the keyboard and stores them in a buffer. You can edit the line before entering it. When you push the `enter` key, all the characters in the line, including the `enter` character at the end, become available to the application. The program in Listing 11-6 reads only one character, leaving the `enter` character in the buffer. The program ends and returns to the shell, which reads the `enter` character from the buffer.
2. If you don't change the offset of `aLetter`, you'll get a stack violation error. I also read two characters from the keyboard to remove the `enter` character from the keyboard buffer.

    ```asm
    # echoChar.s
    # Prompts user to enter a character, then echoes the response
            .intel_syntax noprefix
    # Useful constants
            .equ    STDIN,0
            .equ    STDOUT,1
    # Stack frame
            .equ    aLetter,-10
            .equ    localSize,-16

    # Constant data
            .section  .rodata
    prompt:
            .string "Enter one character: "
            .equ    promptSz,.-prompt-1
    msg:
            .string "You entered: "
            .equ    msgSz,.-msg-1
            .text
    # Code 
            .globl  main
            .type   main, @function
    main:
            push    rbp           # save caller's frame pointer
            mov     rbp, rsp      # establish our frame pointer
            add     rsp, localSize # for local variable

            mov     rax, fs:40    # get stack canary
            mov     -8[rbp], rax  # and save it

            mov     edx, promptSz # prompt size
            lea     rsi, prompt[rip] # address of prompt text string
            mov     edi, STDOUT   # standard out
            call    write@plt     # invoke write function

            mov     edx, 2        # 2 characters
            lea     rsi, aLetter[rbp] # place to store character
            mov     edi, STDIN    # standard in
            call    read@plt      # invoke read function

            mov     edx, msgSz    # message size
            lea     rsi, msg[rip] # address of message text string
            mov     edi, STDOUT   # standard out
            call    write@plt     # invoke write function

            mov     edx, 1        # 1 character
            lea     rsi, aLetter[rbp] # place where character stored
            mov     edi, STDOUT   # standard out
            call    write@plt     # invoke write function

            mov     eax, 0        # return 0

            mov     rcx, -8[rbp]  # retrieve saved canary
            xor     rcx, fs:40    # and check it
            je      goodCanary
            call    __stack_chk_fail@PLT    # bad canary
    goodCanary:
            mov     rsp, rbp      # delete local variables
            pop     rbp           # restore caller's frame pointer
            ret                   # back to calling function
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

2.  Return `int`s
 
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

3.  Return `char`s

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

