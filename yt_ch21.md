---
layout: default
title: Chapter 21
---

## Chapter 21

### Page 474
1. You may not expect what you see when you run this program. Why is this? Even though we're not using the C runtime environment here, we're still using the operating system for our I/O. The operating system itself echos the characters as we type them. Recall that the operating system buffers keyboard input until we hit `ENTER`. Our program then reads the characters from the keyboard buffer (connected through STDIN) one at a time and stores each one in our local variable, `aChar`. The program then writes the character to the screen using a `syscall` instruction.
 
    ```
    # echoTyping.s
    # Shows your typing
    # Does not use C libraries
            .intel_syntax noprefix
    # Useful constants
            .equ    STDIN,0
            .equ    STDOUT,1
            .equ    enter,'\n'
      # from asm/unistd_64.h
            .equ    READ,0
            .equ    WRITE,1
            .equ    EXIT,60
    # Stack frame
            .equ    aChar,-16
            .equ    localSize,-16
    # Data
            .section    .rodata
    msg:
            .ascii  "Enter up to 127 characters and press enter:\n"
            .equ    msgsize, .-msg
    # Code
            .text               # text segment
            .globl  myStart
            .type   myStart, @function
    myStart:
            push    rbp         # save frame pointer
            mov     rbp, rsp    # set new frame pointer
            add     rsp, localSize  # for local var.

            mov     rdx, msgsize    # prompt user
            lea     rsi, msg[rip]
            mov     rdi, STDOUT
            mov     eax, WRITE
            syscall
            
            lea     rbx, aChar[rbp] # place to store input
    rwLoop:
            mov     rdx, 1      # one character
            mov     rsi, rbx
            mov     rdi, STDIN
            mov     eax, READ
            syscall             # request kernel service

            mov     rdx, 1      # one character
            mov     rsi, rbx
            mov     rdi, STDOUT
            mov     eax, WRITE
            syscall             # request kernel service

            cmp     byte ptr [rbx], enter   # enter key?
            je      allDone     # yes, all done
            inc     rbx         # no, increment pointer
            jmp     rwLoop      # and continue
    allDone:
            mov     rsp, rbp    # yes, restore stack pointer
            pop     rbp         # and caller frame pointer
            mov     eax, EXIT   # end this process
            syscall
    ```
