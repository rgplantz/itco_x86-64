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
