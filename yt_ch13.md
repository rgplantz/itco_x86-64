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
            .file   "switch_15.c"
            .intel_syntax noprefix
            .text
            .section        .rodata
    .LC0:
            .string "i = 1"
    .LC1:
            .string "i = 2"
    .LC2:
            .string "i = 3"
    .LC3:
            .string "i > 3"
            .text
            .globl  main
            .type   main, @function
    main:
            push    rbp
            mov     rbp, rsp
            push    r12
            push    rbx
            mov     ebx, 1
            jmp     .L2
    .L8:
            mov     r12d, ebx
            cmp     r12d, 3
            je      .L3
            cmp     r12d, 3
            jg      .L4
            cmp     r12d, 1
            je      .L5
            cmp     r12d, 2
            je      .L6
            jmp     .L4
    .L5:
            lea     rdi, .LC0[rip]
            call    puts@PLT
            jmp     .L7
    .L6:
            lea     rdi, .LC1[rip]
            call    puts@PLT
            jmp     .L7
    .L3:
            lea     rdi, .LC2[rip]
            call    puts@PLT
            jmp     .L7
    .L4:
            lea     rdi, .LC3[rip]
            call    puts@PLT
    .L7:
            add     ebx, 1
    .L2:
            cmp     ebx, 15
            jle     .L8
            mov     eax, 0
            pop     rbx
            pop     r12
            pop     rbp
            ret
            .size   main, .-main
            .ident  "GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
            .section        .note.GNU-stack,"",@progbits
    ```
3.  zzz
    ```asm
    # switch.s
    # Three-way switch using jump table
            .intel_syntax noprefix
    # Useful constants
            .equ    LIMIT, 15
    # Constant data
            .section  .rodata
    oneMsg:
            .string "i = 1"
    twoMsg:
            .string "i = 2"
    threeMsg:
            .string "i = 3"
    overMsg:
            .string "i > 3"
    # Jump table
            .align 8
    jumpTable:
            .quad   one     # addresses where messages are
            .quad   two     #   printed
            .quad   three
            .quad   over
            .quad   over
            .quad   over
            .quad   over
            .quad   over
            .quad   over    # need an entry for
            .quad   over    #    each possibility
            .quad   over    # add five for additional
            .quad   over    #    possibilities
            .quad   over
            .quad   over
            .quad   over
    # Program code
            .text
            .globl  main
            .type   main, @function
    main:
            push    rbp         # save frame pointer
            mov     rbp, rsp    # set new frame pointer
            push    rbx
            push    r12         # save, use for i

            mov     r12, 1      # i = 1;
    for:
            cmp     r12, LIMIT  # at limit?
            ja      done        # yes, all done
    # List of cases
            lea     rax, jumpTable[rip]
            mov     rbx, r12    # current location in loop
            sub     rbx, 1      # count from 0
            shl     rbx, 3      # multiply by 8
            add     rax, rbx    # location in jumpTable
            mov     rax, [rax]  # get address from jumpTable
            jmp     rax         # jump there
    one:
            lea     rdi, oneMsg[rip]
            call    puts@plt    # display message
            jmp     endSwitch
    two:
            lea     rdi, twoMsg[rip]
            call    puts@PLT
            jmp     endSwitch
    three:
            lea     rdi, threeMsg[rip]
            call    puts@plt
            jmp     endSwitch
    over:
            lea     rdi, overMsg[rip]
            call    puts@plt
    endSwitch:
            inc     r12         # i++;
            jmp     for         # loop back
    done:
            mov     eax, 0      # return 0;
            pop     r12         # restore regs
            pop     rbx
            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # restore frame pointer
            ret
    ```

