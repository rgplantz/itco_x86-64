---
layout: default
title: Chapter 11
---

## Chapter 11

### Page 241
1.  The operating system reads characters as you type them on the keyboard and stores them in a buffer. You can edit the line before entering it. When you push the `enter` key, all the characters in the line, including the `enter` character at the end, become available to the application. The program in Listing 11-6 reads only one character, leaving the `enter` character in the buffer. The program ends and returns to the shell, which reads the `enter` character from the buffer.
2.  Change the `mov edx, 1` instruction just before the call to the `read` function to 'mov edx,2` so that it reads two characters from the keyboard to remove the `enter` character from the keyboard buffer. Note that you also need to change the offset of `aLetter` to avoid getting a stack violation error. 
3.  My `main` function here allocates sixteen bytes for local variables in the stack frame. Eight are for the stack canary, leaving eight for the message. When you increase the length of the message beyond eigth bytes (don't forget to include the newline and NUL characters) the `theMessage` function overwrites the stack canary, and you get an error message.
    ```asm
    # message.s
    # Prints a message on screen
            .intel_syntax noprefix
    # Stack frame
            .equ    aMessage,-16
            .equ    localSize,-16

    # Constant data
            .section  .rodata
    format:
            .string "There are %i characters in %s\n"

            .text
    # Code 
            .globl  main
            .type   main, @function
    main:
            push    rbp             # save caller's frame pointer
            mov     rbp, rsp        # establish our frame pointer
            add     rsp, localSize  # for local variable

            mov     rax, fs:40      # get stack canary
            mov     -8[rbp], rax    # and save it

            lea     rdi, aMessage[rbp]  # place to put message
            call    theMessage      # get the message

            lea     rdx, aMessage[rbp]  # the message
            mov     esi, eax        # number of characters
            lea     rdi, format[rip]    # format string
            mov     eax, -0         # no floating point
            call    printf@plt      # print it

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
