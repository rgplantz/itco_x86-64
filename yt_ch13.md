---
layout: default
title: Chapter 13
---

## Chapter 13

### Page 276
1.  You can do this one on your own. When I did it, the `while` loop and `for` loop were implemented with exactly the same assembly language. The `do-while` loop was different, since it always executes the body of the loop at least once.
2.  
    ```asm
    # echoTyping.s
    # Echos your typing
            .intel_syntax noprefix
    # Useful constants
            .equ    STDIN,0
            .equ    STDOUT,1
            .equ    ENTER,'\n'
    # from asm/unistd_64.h
            .equ    READ,0
            .equ    WRITE,1
    # Stack frame
            .equ    theText,-128
            .equ    localSize,-128
    # Data
            .section    .rodata
    msg1:
            .ascii  "Enter up to 127 characters and press enter:\n"
            .equ    msg1size, .-msg1
    msg2:
            .ascii  "You entered:\n"
            .equ    msg2size, .-msg2
            
    # Code
            .text               # text segment
            .globl  main
            .type   main, @function
    main:
            push    rbp         # save frame pointer
            mov     rbp, rsp    # set new frame pointer
            add     rsp, localSize  # for local var.

            mov     rdx, msg1size   # prompt user
            lea     rsi, msg1[rip]
            mov     edi, STDOUT
            call    write@plt
            
            lea     rbx, theText[rbp]   # place to store input
    readLoop:
            mov     rdx, 1      # one character
            mov     rsi, rbx
            mov     rdi, STDIN
            call    read@plt
            cmp     byte ptr [rbx], ENTER   # enter key?
            je      show        # yes, show user
            inc     rbx         # no, increment pointer
            jmp     readLoop    # and continue
    show:
            mov     rdx, msg2size   # show user
            lea     rsi, msg2[rip]
            mov     rdi, STDOUT
            call    write@plt

            lea     rbx, theText[rbp]   # place input stored
    writeLoop:
            mov     rdx, 1      # one character
            mov     rsi, rbx
            mov     rdi, STDOUT
            call    write@plt
            cmp     byte ptr [rbx], ENTER   # enter key?
            je      allDone     # yes, all done
            inc     rbx         # no, increment pointer
            jmp     writeLoop   # and continue
    allDone:
            mov     eax, 0      # return 0;
            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # and caller frame pointer
            ret                 # end program
    ``` 
### Page 286
1.  xxx
    ```asm
    # coinFlipsEndsMid.s
    # flips a coin, heads/tails
            .intel_syntax noprefix

    # Useful constants
            .equ    TOP, 1610612734    # top fourth of RAND_MAX
            .equ    BOTTOM, 536870911  # bottom fourth of RAND_MAX
            .equ    STACK_ALIGN, 8

    # Constant data
            .section .rodata
    headsMsg:
            .string	"heads"
    tailsMsg:
            .string	"tails"

    # The code
            .text
            .globl  main
            .type   main, @function
    main:
            push    rbp         # save frame pointer
            mov     rbp, rsp    # set new frame pointer
            push    r12     # save, use for i
            sub     rsp, STACK_ALIGN
            
            mov     r12, 0  # i = 0;
    for:
            cmp     r12, 10 # any more?
            jae     done    # no, all done
            
            call    random@plt          # get a random number
            cmp     eax, BOTTOM         # in bottom fourth?
            jbe     heads               # yes, it's heads
            cmp     eax, TOP            # no, in top fourth?
            ja      heads               # yes, it's heads
            lea     rdi, tailsMsg[rip]  # neither, it was tails
            call    puts@plt
            jmp     next    # jump over else block
    heads:
            lea     rdi, headsMsg[rip]  # it was heads
            call    puts@plt
    next:   inc     r12     # i++;
            jmp     for
    done:
            add     rsp, STACK_ALIGN    # realign stack ptr
            pop     r12     # restore for caller
            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # restore frame pointer
      ret
    ```
2.  yyy
    ```asm
    ```
3.  zzz
    ```asm
    ```

