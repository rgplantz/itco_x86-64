---
layout: default
title: Chapter 16
---

## Chapter 16

### Page 3xx
1. My first thought was that I only needed to change `upperMask` to `lowerMask` with the proper bit pattern and then change the `and     al, upperMask` instruction to `and     al, upperMask` in order to change the `toUpper` function to give me the `toLower` function. If you tried this, what happened? I got a segmentation fault. What caused this problem? Hint: running under `gdb`, set a breakpoint at the `cmp     al, NUL` instruction in the `toLower` function and test the program with just one or two input characters. Here's how I modified the algorithm for the `toLower` function.
   
    ```asm
    # toLower.s
    # Converts alphabetic characters in a C string to lower case.
    # Calling sequence:
    #   rdi <- pointer to source string
    #   rsi <- pointer to destination string
    #   returns number of characters processed.
            .intel_syntax noprefix

    # Stack frame
            .equ    count,-4
            .equ    localSize,-16
    # Useful constants
            .equ    lowerMask,0x20
            .equ    NUL,0
    # Code
            .text
            .globl  toLower
            .type   toLower, @function
    toLower:
            push    rbp         # save frame pointer
            mov     rbp, rsp    # set new frame pointer
            add     rsp, localSize      # for local var.
            
            mov     dword ptr count[rbp], 0
    whileLoop:
            mov 	  al, byte ptr [rdi]  # char from source
            mov     byte ptr [rsi], al  # char to destination
            cmp     al, NUL             # was it the end?
            je      allDone             # yes, all done
            or      byte ptr [rsi], lowerMask # no, make sure it's lower
            inc     rdi         # increment
            inc     rsi         #      pointers
            inc     dword ptr count[rbp]    # and counter
            jmp     whileLoop   # continue loop
    allDone:
            mov     byte ptr [rsi], al  # finish with NUL
            mov     eax, dword ptr count[rbp]   # return count

            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # and caller frame pointer
            ret
    ```
### Page 351
1. xxx

    ```c
    /* convertHex.c
     * Gets hex number from user and stores it as int.
     */
    #include <stdio.h>
    #include "writeStr.h"
    #include "readLn.h"
    #include "hexToInt.h"

    #define MAX 20

    int main()
    {
      char theString[MAX];
      long int theInt;
      int count;
      
      writeStr("Enter up to 16 hex characters: ");
      readLn(theString, MAX);

      count = hexToInt(theString, &theInt);
      printf("The %i characers %lx = %li\n", count, theInt, theInt);
      return 0;
    }
    ```
    ```c
    /* hexToInt.h
     * Converts hex character string to int.
     * Returns number of characters.
     */
    
    #ifndef HEXTOINT_H
    #define HEXTOINT_H
    int hexToInt(char *stringPtr, long int *intPtr);
    #endif
    ```
    ```asm
    # hexToInt.s
    # Converts hex characters in a C string to int.
    # Calling sequence:
    #   rdi <- pointer to source string
    #   rsi <- pointer to long int result
    #   returns number of chars converted
            .intel_syntax noprefix

    # Stack frame
            .equ    count,-4
            .equ    localSize,-16
    # Useful constants
            .equ    GAP,0x07
            .equ    NUMMASK,0x0f    # also works for lower case
            .equ    NUL,0
            .equ    NINE,0x39       # ASCII for '9'
    # Code
            .text
            .globl  hexToInt
            .type   hexToInt, @function
    hexToInt:
            push    rbp         # save frame pointer
            mov     rbp, rsp    # set new frame pointer
            add     rsp, localSize      # for local var.

            mov     dword ptr count[rbp], 0 # count = 0
            mov     qword ptr [rsi], 0    # initialize to 0
            mov     al, byte ptr [rdi]  # get a char
    whileLoop:
            cmp     al, NUL     # end of string?
            je      allDone     # yes, all done
            cmp     al, NINE    # no, is it alpha?
            jbe     numeral     # no, nothing else to do
            sub     al, GAP     # yes, numeral to alpha gap
    numeral:
            and     al, NUMMASK # convert to 4-bit int
            sal     qword ptr [rsi], 4  # make room
            or      byte ptr [rsi], al  # insert the 4 bits
            inc     dword ptr count[rbp]    # count++
            inc     rdi         # increment string ptr
            mov     al, byte ptr [rdi]  # next char
            jmp     whileLoop   # and continue
    allDone:
            mov     eax, dword ptr count[rbp]   # return count

            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # and caller frame pointer
            ret
    ```

2. yyy

    ```asm
    # convertOctal.s
            .intel_syntax noprefix
    # Stack frame
            .equ    myString,-48
            .equ    myInt, -16
            .equ    canary,-8
            .equ    localSize,-48
    # Useful constants
            .equ    MAX,23  # character buffer limit
    # Constant data
            .section	.rodata
            .align 8
    prompt:
            .string	"Enter up to 21 octal characters (can be prefaced by 1): "
    format:
            .string	"0%lo = %li\n"
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
            
            mov     esi, MAX    # get user input
            lea     rdi, myString[rbp]
            call    readLn

            lea     rsi, myInt[rbp]     # for result
            lea     rdi, myString[rbp]  # convert to int
            call    octalToInt

            mov     rdx, myInt[rbp]     # converted value
            mov     rsi, myInt[rbp]
            lea     rdi, format[rip]    # printf format string
            mov     eax, 0
            call	printf
            
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
    ```asm
    # octalToInt.s
    # Converts octal characters in a C string to int.
    # Calling sequence:
    #   rdi <- pointer to source string
    #   rsi <- pointer to long int result
    #   returns number of chars converted
            .intel_syntax noprefix

    # Stack frame
            .equ    count,-4
            .equ    localSize,-16
    # Useful constants
            .equ    NUMMASK,0x07
            .equ    NUL,0
    # Code
            .text
            .globl  octalToInt
            .type   octalToInt, @function
    octalToInt:
            push    rbp         # save frame pointer
            mov     rbp, rsp    # set new frame pointer
            add     rsp, localSize      # for local var.

            mov     dword ptr count[rbp], 0 # count = 0
            mov     qword ptr [rsi], 0    # initialize to 0
            mov     al, byte ptr [rdi]  # get a char
    whileLoop:
            cmp     al, NUL     # end of string?
            je      allDone     # yes, all done
            and     al, NUMMASK # convert to 4-bit int
            sal     qword ptr [rsi], 3  # make room
            or      byte ptr [rsi], al  # insert the 3 bits
            inc     dword ptr count[rbp]    # count++
            inc     rdi         # increment string ptr
            mov     al, byte ptr [rdi]  # next char
            jmp     whileLoop   # and continue
    allDone:
            mov     eax, dword ptr count[rbp]   # return count

            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # and caller frame pointer
            ret
    ```

### Page 360
1. xxx
2. yyy
