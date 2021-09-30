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
        .globl  myStart
        .type   myStart, @function
myStart:
        push    rbp         # save frame pointer
        mov     rbp, rsp    # set new frame pointer
        add     rsp, localSize  # for local var.

        mov     rdx, msg1size   # prompt user
        lea     rsi, msg1[rip]
        mov     rdi, STDOUT
        mov     eax, WRITE
        syscall
        
        lea     rbx, theText[rbp]   # place to store input
readLoop:
        mov     rdx, 1      # one character
        mov     rsi, rbx
        mov     rdi, STDIN
        mov     eax, READ
        syscall             # request kernel service
        cmp     byte ptr [rbx], enter   # enter key?
        je      show        # yes, show user
        inc     rbx         # no, increment pointer
        jmp     readLoop    # and continue
show:
        mov     rdx, msg2size   # show user
        lea     rsi, msg2[rip]
        mov     rdi, STDOUT
        mov     eax, WRITE
        syscall

        lea     rbx, theText[rbp]   # place input stored
writeLoop:
        mov     rdx, 1      # one character
        mov     rsi, rbx
        mov     rdi, STDOUT
        mov     eax, WRITE
        syscall             # request kernel service
        cmp     byte ptr [rbx], enter   # enter key?
        je      allDone     # yes, all done
        inc     rbx         # no, increment pointer
        jmp     writeLoop   # and continue
allDone:
        mov     rsp, rbp    # yes, restore stack pointer
        pop     rbp         # and caller frame pointer
        mov     eax, EXIT   # end this process
        syscall

