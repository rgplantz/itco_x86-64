---
layout: default
title: Chapter 20
---

## Chapter 20

### Page 449
1. I chose my `addFloats` and `recordField` programs.
 
    ```
    Breakpoint 1, main () at addFloats.s:23
    23	        push    rbp         # save frame pointer
    (gdb) i r rip rsp
    rip            0x555555555159      0x555555555159 <main>
    rsp            0x7fffffffde78      0x7fffffffde78
    ```

    ```
    Breakpoint 1, main () at recordField.s:22
    22	        push    rbp         # save frame pointer
    (gdb) i r rip rsp
    rip            0x555555555139      0x555555555139 <main>
    rsp            0x7fffffffde98      0x7fffffffde98
    ```
   The addresses in the `rsp` and `rip` register differ by only 32 bytes, which looks like they're running in the same place in memory. But these are virtual memory addresses. The operating system loads the two programs in different physical memory locations and uses the page map table to translate between the two memory address spaces.

### Page 459
1. Well, I did try to run the program. The operating system gave me an error message:

    ```
    $ gcc -c -O0 -Wall -masm=intel -g UART_functions.c
    $ gcc -c -O0 -Wall -masm=intel -g UART_echo.c
    $ ld -e myProg -o UART_echo UART_echo.o UART_functions.o
    $ ./UART_echo 
    Segmentation fault (core dumped)    ```
    ```

   The operating system prevents us from accessing I/O directly from a user program.
2. As with the C version, the operating system prvents us from accessing I/O.

    ```
    as --gstabs -o UART_functions.o UART_functions.s
    ld -e myProg -o UART_echo UART_echo.o UART_functions.o
    $ ./UART_echo 
    Segmentation fault (core dumped)
    ```

### Page 463
1. We need to use the base UART port address for the port-mapped version.

    ```c
    /* UART_echo.c
    * Use a UART to echo a single character.
    * WARNING: This code does not run on any known
    *          device. It is meant to sketch some
    *          general I/O concepts only.
    */

    #include "UART_functions.h"
    #define UART0 (unsigned short int)0x3f8  /* location of UART */

    int myProg() {
      unsigned char aCharacter;

      UART_init(UART0);
      aCharacter = UART_in(UART0);
      UART_out(UART0, aCharacter);
      
      return 0;
    }

    ```
    ```c
    /* UART_functions.h
    * Initialize, read, and write functions for an abstract UART.
    * WARNING: This code does not run on any known
    *          device. It is meant to sketch some
    *          general I/O concepts only.
    */
    #ifndef UART_FUNCTIONS_H
    #define UART_FUNCTIONS_H
    void UART_init(unsigned short int UART);       /* initialize UART  */
    unsigned char UART_in(unsigned short int UART);          /* input  */
    void UART_out(unsigned short int UART, unsigned char c); /* output */
    #endif
    ```
    ```
    # UART_functions.s
    # Initialize, read, and write functions for an abstract UART.
    # WARNING: This code does not run on any known
    #          device. It is meant to sketch some
    #          general I/O concepts only.
            .intel_syntax noprefix

            .include "UART_defs"

    # Intialize the UART
    # Calling sequence:
    #   rdi <- base port of UART
            .text
            .globl  UART_init
            .type   UART_init, @function
    UART_init:
            push    rbp         # save frame pointer
            mov     rbp, rsp    # set new frame pointer

        # no interrupts, don't use FIFO queue
            lea     dx, IER[rdi]  # interrupt enable port
            mov     al, NOINTERRUPT
            out     dx, al
            lea     dx, FCR[rdi]  # FIFO control port
            mov     al, NOFIFO
            out     dx, al
        # set divisor latch access bit = 1 to set baud
            lea     dx, LCR[rdi]  # line control port
            mov     al, SETBAUD
            out     dx, al
            lea     dx, DLM[rdi]  # divisor high-order byte
            mov     al, MSB38400
            out     dx, al
            lea     dx, DLL[rdi]  # divisor low-order byte
            mov     al, LSB38400
            out     dx, al
        # divisor latch access bit = 0 for communications mode
            lea     dx, LCR[rdi]  # line control port
            mov     al, SETCOM
            out     dx, al
            
            mov     rsp, rbp    # yes, restore stack pointer
            pop     rbp         # and caller frame pointer
            ret

    # Input a single character
    # Calling sequence:
    #   rdi <- base address of UART
    #   returns character in al register
            .globl  UART_in
            .type   UART_in, @function
    UART_in:
            push    rbp         # save frame pointer
            mov     rbp, rsp    # set new frame pointer

    inWaitLoop:
            lea     dx, LSR[rdi]  # line status port
            in      al, dx
            and     al, RxRDY   # character ready?
            jne     inWaitLoop  # no, wait
            lea     dx, RBR[rdi]  # yes, receiver buffer
            in      al, dx      #       get character
            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # and caller frame pointer
            ret
      
    # Output a single character in sil register
    # Calling sequence:
    #   rdi <- base address of UART
    #   sil <- character to output
            .globl	UART_out
            .type	UART_out, @function
    UART_out:
            push    rbp         # save frame pointer
            mov     rbp, rsp    # set new frame pointer

    outWaitLoop:
            lea     dx, LSR[rdi]  # line status port
            in      al, dx
            and     al, TxRDY   # ready for character?
            jne     inWaitLoop  # no, wait
            lea     dx, THR[rdi]  # yes, transmitter holding
            mov     al, sil     # need character in al
            out     dx, al      #     send character
            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # and caller frame pointer
            ret
    ```
