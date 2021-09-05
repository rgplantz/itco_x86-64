---
layout: default
title: Chapter 14
---

## Chapter 14

### Page 308
1.  
    ```asm
    # sum9Ints.s
    # Sums the integers 1 - 9.
            .intel_syntax noprefix
            
    # Stack frame
    #   passing arguments on stack (rsp)
    #     need 9x8 = 72 -> 80 bytes
            .equ    first,0
            .equ    second,8
            .equ    third,16
            .equ    fourth,24
            .equ    fifth,32
            .equ    sixth,40
            .equ    seventh,48
            .equ    eighth,56
            .equ    ninth,64
            .equ    argSize,-80
    #   local vars (rbp)
    #     need 10x4 = 40 -> 48 bytes for alignment
            .equ    i,-4
            .equ    h,-8
            .equ    g,-12
            .equ    f,-16
            .equ    e,-20
            .equ    d,-24
            .equ    c,-28
            .equ    b,-32
            .equ    a,-36
            .equ    total,-40
            .equ    localSize,-48
    # Read only data
            .section  .rodata
    format:
            .string "The sum is %i\n"
    # Code
            .text
            .globl  main
            .type   main, @function
    main:
            push    rbp             # save frame pointer
            mov     rbp, rsp        # set new frame pointer
            add     rsp, localSize  # for local var.
            
            mov     dword ptr a[rbp], 1 # initialize values
            mov	    dword ptr b[rbp], 2 #     etc...
            mov     dword ptr c[rbp], 3
            mov	    dword ptr d[rbp], 4
            mov	    dword ptr e[rbp], 5
            mov	    dword ptr f[rbp], 6
            mov	    dword ptr g[rbp], 7
            mov     dword ptr h[rbp], 8
            mov	    dword ptr i[rbp], 9

            add     rsp, argSize    # space for arguments
            mov     eax, i[rbp]     # load i
            mov     ninth[rsp], rax #   9th argument
            mov     eax, h[rbp]     # load h
            mov     eighth[rsp], rax  #   8th argument
            mov     eax, g[rbp]     # load g
            mov	    seventh[rsp], rax #   7th argument
            mov     eax, f[rbp]     # load f
            mov     sixth[rsp], rax #   6th argument
            mov     eax, e[rbp]     # load e
            mov     fifth[rsp], rax #   5th argument
            mov     eax, d[rbp]     # load d
            mov	    fourth[rsp], rax  #   4th argument
            mov     eax, c[rbp]     # load c
            mov     third[rsp], rax   #   3rd argument
            mov     eax, b[rbp]     # load b
            mov     second[rsp], rax  #   2nd argument
            mov     eax, a[rbp]     # load a
            mov	    first[rsp], rax #   1st argument
            call    addNine
            sub     rsp, argSize    # remove arguments
            mov     total[rbp], eax # total = sumNine(...)
      
            mov     esi, total[rbp] # show result
            lea     rdi, format[rip]
            mov     eax, 0
            call    printf@plt

            mov     eax, 0          # return 0;
            mov     rsp, rbp        # restore stack pointer
            pop     rbp             # and caller frame pointer
            ret
    ```
    ```asm
    # addNine.s
    # Sums nine integer arguments and returns the total.
            .intel_syntax noprefix
    # Calling sequence:
    #       push one
    #       push two
    #       push three
    #       push four
    #       push five
    #       push six
    #       push seven
    #       push eight
    #       push nine
    #       returns sum
    # Stack frame
    #    arguments in stack frame
            .equ    one,16
            .equ    two,24
            .equ    three,32
            .equ    four,40
            .equ    five,48
            .equ    six,56
            .equ    seven,64
            .equ    eight,72
            .equ    nine,80
    #    local variables
            .equ    total,-4
            .equ    localSize,-16

    # Code
            .text
            .globl  addNine
            .type   addNine, @function
    addNine:
            push    rbp             # save frame pointer
            mov     rbp, rsp        # set new frame pointer
            add     rsp, localSize  # for local var.

            mov     eax, one[rbp]   # retrieve one
            add     eax, two[rbp]   # add two
            add     eax, three[rbp] # plus three
            add     eax, four[rbp]  # plus four
            add     eax, five[rbp]  # plus five
            add     eax, six[rbp]   # plus six
            add     eax, seven[rbp] # plus seven
            add     eax, eight[rbp] # plus eight
            add     eax, nine[rbp]  # plus nine

            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # and caller framee pointer
            ret
    ```
2.  
    ```asm
    # sumRange.s
    # Sums the integers 1 - 9.
            .intel_syntax noprefix
            
    # Stack frame
    #   local vars (rbp)
            .equ    nLow,-4
            .equ    nHigh,-8
            .equ    total,-12
            .equ    localSize,-16
    # Read only data
            .section  .rodata
    readFormat:
            .string "%i"
    lowerFormat:
            .string "Enter lower number: "
    higherFormat:
            .string "Enter higher number: "
    result:
            .string "Sum of all integers between them = %i\n"
    # Code
            .text
            .globl  main
            .type   main, @function
    main:
            push    rbp             # save frame pointer
            mov     rbp, rsp        # set new frame pointer
            add     rsp, localSize  # for local var.

            lea     rdi, lowerFormat[rip]   # ask for lower number
            mov     eax, 0
            call    printf@plt
            lea     rsi, nLow[rbp]  # get lower number
            lea     rdi, readFormat[rip]
            mov     eax, 0
            call    __isoc99_scanf@plt
            
            lea     rdi, higherFormat[rip]  # ask for higher number
            mov     eax, 0
            call    printf@plt
            lea     rsi, nHigh[rbp] # get higher number
            lea     rdi, readFormat[rip]
            mov     eax, 0
            call    __isoc99_scanf@plt
            
            mov     esi, nHigh[rbp] # nHigh
            mov     edi, nLow[rbp]  # nLow
            call    addRange
            mov     total[rbp], eax # total = sumNine(...)
      
            mov     esi, total[rbp] # show result
            lea     rdi, result[rip]
            mov     eax, 0
            call    printf@plt

            mov     eax, 0          # return 0;
            mov     rsp, rbp        # restore stack pointer
            pop     rbp             # and caller frame pointer
            ret
    ```
    ```asm
    # addRange.s
    # Sums all integers between two integers and returns the total.
            .intel_syntax noprefix
    # Calling sequence:
    #       edi <- lower number
    #       esi <- higher number
    #       returns sum

    # Code
            .text
            .globl  addRange
            .type   addRange, @function
    addRange:
            push    rbp             # save frame pointer
            mov     rbp, rsp        # set new frame pointer

            mov     eax, edi        # start with lower number
    while:
            cmp     edi, esi        # are we there?
            jge     allDone         # yes, all done
            inc     edi             # no, next integer
            add     eax, edi        # add it in to total
            jmp     while           # and continue
    allDone:
            mov     rsp, rbp        # restore stack pointer
            pop     rbp             # and caller frame pointer
            ret
    ```

3.  Don't forget that we need C header files for our `writeStr` and `readLn` assembly language functions so we can call them from C. We'll be using the `writeStr` and `readLn` functions in subsequent programs, so make sure that you get them to work correctly. I have placed the files in a `common` directory on my computer, and I link to them in any project directory that uses them. This avoids having multiple copies that may get out of sync.

    ```c
    /* echo.c
    * Prompts user to enter text and echos it.
    */

    #include "writeStr.h"
    #include "readLn.h"
    #define MAX 5

    int main(void)
    {
      char text[MAX];
      
      writeStr("Enter some text: ");
      readLn(text, MAX);
      writeStr("You entered: ");
      writeStr(text);
      writeStr("\n");
      
      return 0;
    }
    ```
    ```c
    /* writeStr.h
    * C header file for writeStr assembly language function
    * Writes a C-style text string to the standard output (screen).
    * Calling sequence:
    *       rdi <- address of string to be written
    *       call    writestr
    * returns number of characters written
    */
    

    #ifndef WRITESTR_H
    #define WRITESTR_H

    int writeStr(char *);

    #endif
    ```
    ```asm
    # writeStr.s
    # Writes a C-style text string to the standard output (screen).
    # Calling sequence:
    #       rdi <- address of string to be written
    #       call    writestr
    # returns number of characters written
            .intel_syntax noprefix

    # Useful constants
            .equ    STDOUT,1
            .equ    NUL,0
    # Stack frame, showing local variables and arguments
            .equ    stringAddr,-16
            .equ    count,-4
            .equ    localSize,-16

            .text
            .globl  writeStr
            .type   writeStr, @function
    writeStr:
            push    rbp             # save frame pointer
            mov     rbp, rsp        # set new frame pointer
            add     rsp, localSize  # for local var.

            mov     stringAddr[rbp], rdi    # save string pointer
            mov     dword ptr count[rbp], 0 # count = 0;
    writeLoop:
            mov     rax, stringAddr[rbp]    # get current pointer
            cmp     byte ptr [rax], NUL     # at end yet?
            je      done             # yes, all done
    
            mov     edx, 1          # no, write one character
            mov     rsi, rax        # points to current char
            mov     edi, STDOUT     # on the screen
            call    write@plt
            inc     dword ptr count[rbp]    # count++;
            inc     qword ptr stringAddr[rbp] # stringAddr++;
            jmp     writeLoop       # and check for end
    done:
            mov     eax, count[rbp] # return total;
            mov     rsp, rbp        # restore stack pointer
            pop     rbp             # and caller frame pointer
            ret
    ```
    ```c
    /* readLn.h
    * C header file for readLn assembly language function
    * Reads a line (through the '\n' character from standard input. Deletes
    * the '\n' and creates a C-style text string.        
    * Calling sequence:
    *       rsi <- length of char array
    *       rdi <- address of place to store string
    *       call    readLn
    * returns number of characters read (not including NUL)
    */

    #ifndef READLN_H
    #define READLN_H

    int readLn(char *, int);

    #endif
    ```
    ```asm
    # readLn.s
    # Reads a line (through the '\n' character from standard input. Deletes
    # the '\n' and creates a C-style text string.        
    # Calling sequence:
    #       rsi <- length of char array
    #       rdi <- address of place to store string
    #       call    readLn
    # returns number of characters stored (not including NUL)
            .intel_syntax noprefix

    # Useful constant
            .equ    STDIN,0
    # Stack frame, showing local variables and arguments
            .equ    maxLength,-24
            .equ    stringAddr,-16
            .equ    count,-4
            .equ    localSize,-32

            .text
            .globl  readLn
            .type   readLn, @function
    readLn:
            push    rbp             # save frame pointer
            mov     rbp, rsp        # set new frame pointer
            add     rsp, localSize  # for local var.

            mov     maxLength[rbp], rsi  # save max storage space
            mov     stringAddr[rbp], rdi # save string pointer

            mov     dword ptr count[rbp], 0  # count = 0;
            sub     dword ptr maxLength[rbp], 1  # room for NUL char
            
            mov     edx, 1          # read one character
            mov     rsi, stringAddr[rbp]  # into storage area
            mov     edi, STDIN            # from keyboard
            call    read@plt
    readLoop:
            mov     rax, stringAddr[rbp]  # get pointer
            cmp     byte ptr [rax], '\n'  # return key?
            je      endOfString           # yes, mark end of string
            mov     eax, count[rbp]       # current count
            cmp     maxLength[rbp], eax   # is caller's array full?
            jbe     skipStore             # yes, don't store

            inc     qword ptr stringAddr[rbp] # no, next byte
            inc     dword ptr count[rbp]      # count++;
    skipStore:      
            mov     edx, 1          # get another character
            mov     rsi, stringAddr[rbp]  # into storage area
            mov     edi, STDIN      # from keyboard
            call    read@plt
            jmp     readLoop        # and look at it
            
    endOfString:
            mov     rax, stringAddr[rbp]  # current pointer
            mov     byte ptr [rax], 0     # mark end of string
      
            mov     eax, count[rbp] # return total;
            mov     rsp, rbp        # restore stack pointer
            pop     rbp             # and caller frame pointer
            ret
    ```

### Page 318
1.  Counting number of times `addConst` is called.

    ```asm
    # varLife.s
    # Compares scope and lifetime of automatic, static, and global variables.
            .intel_syntax noprefix

    # Stack frame
            .equ    x,-8
            .equ    y,-4
            .equ    localSize,-16
    # Useful constants
            .equ    INITx,12
            .equ    INITy,34
            .equ    INITz,56
            .section    .rodata
            .align  8
    tableHead1:
            .string "           automatic   static   global"
    tableHead2:
            .string "                   x        y        z"
    format:
            .string "In main:%12i %8i %8i\n"
    # Define global variable
            .data
            .align 4
            .globl  z
            .type   z, @object
    z:
            .int    INITz   # initialize the global
    # Code
            .text
            .globl  main
            .type   main, @function
    main:
            push    rbp         # save frame pointer
            mov     rbp, rsp    # set new frame pointer
            add     rsp, localSize  # for local var.

            mov     dword ptr x[rbp], INITx  # initialize locals
            mov     dword ptr y[rbp], INITy 

            lea     rdi, tableHead1[rip]    # print heading
            call    puts@plt
            lea     rdi, tableHead2[rip]
            call    puts@plt
            mov     ecx, z[rip]   # print variables
            mov     edx, y[rbp]
            mov     esi, x[rbp]
            lea     rdi, format[rip]
            mov     eax, 0
            call    printf@plt

            call    addConstCount       # add to variables
            call    addConstCount

            mov     ecx, z[rip]   # print variables
            mov     edx, y[rbp]
            mov     esi, x[rbp]
            lea     rdi, format[rip]
            mov     eax, 0
            call    printf@plt

            mov     eax, 0      # return 0;
            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # and caller frame pointer
            ret
    ```
    ```asm
    # addConst.s
    # Adds constant to automatic, static, global variables.
            .intel_syntax noprefix

    # Stack frame
            .equ    x,-4
            .equ    localSize,-16
    # Useful constants
            .equ    ADDITION,1000
            .equ    INITx,78
            .equ    INITy,90
            .equ    INITn,0
    # Constant data
            .section  .rodata
            .align  8
    format:
            .string "In addConst:%8i %8i %8i  called %i times\n"
    # Define static variables
            .data
            .align 4
            .type   y_addConst, @object
    y_addConst:
            .int    INITy
            .type   n_addConst, @object
    n_addConst:
            .int    INITn

    # Code
            .text
            .globl  addConstCount
            .type   addConstCount, @function
    addConstCount:
            push    rbp           # save frame pointer
            mov     rbp, rsp      # set new frame pointer
            add     rsp, localSize  # for local var.
            mov     dword ptr x[rbp], INITx   # initialize

            inc     dword ptr n_addConst[rip]
            add     dword ptr x[rbp], ADDITION # add to vars
            add     dword ptr y_addConst[rip], ADDITION
            add     dword ptr z[rip], ADDITION

            mov     r8d, n_addConst[rip]
            mov     ecx, z[rip]   # print variables
            mov     edx, y_addConst[rip]
            mov     esi, x[rbp]
            lea     rdi, format[rip]
            mov     eax, 0          # no floats
            call    printf@plt

            mov     eax, 0      # return 0;
            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # and caller frame pointer
            ret
    ```
2.  Two `addConst` functions that have separate static variables.
    ```asm
    # varLife2.s
    # Compares scope and lifetime of automatic, static, and global variables.
            .intel_syntax noprefix

    # Stack frame
            .equ    x,-8
            .equ    y,-4
            .equ    localSize,-16
    # Useful constants
            .equ    INITx,12
            .equ    INITy,34
            .equ    INITz,56
            .section    .rodata
            .align  8
    tableHead1:
            .string "           automatic   static   global"
    tableHead2:
            .string "                   x        y        z"
    format:
            .string "In main: %12i %8i %8i\n"
    # Define global variable
            .data
            .align 4
            .globl  z
            .type   z, @object
    z:
            .int    INITz   # initialize the global
    # Code
            .text
            .globl  main
            .type   main, @function
    main:
            push    rbp         # save frame pointer
            mov     rbp, rsp    # set new frame pointer
            add     rsp, localSize  # for local var.

            mov     dword ptr x[rbp], INITx  # initialize locals
            mov     dword ptr y[rbp], INITy 

            lea     rdi, tableHead1[rip]    # print heading
            call    puts@plt
            lea     rdi, tableHead2[rip]
            call    puts@plt
            mov     ecx, z[rip]   # print variables
            mov     edx, y[rbp]
            mov     esi, x[rbp]
            lea     rdi, format[rip]
            mov     eax, 0
            call    printf@plt

            call    addConst0       # add to variables
            call    addConst1
            call    addConst0
            call    addConst1

            mov     ecx, z[rip]   # print variables
            mov     edx, y[rbp]
            mov     esi, x[rbp]
            lea     rdi, format[rip]
            mov     eax, 0
            call    printf@plt

            mov     eax, 0      # return 0;
            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # and caller frame pointer
            ret
    ```
    ```asm
    # addConst2.s
    # Adds constant to automatic, static, global variables.
            .intel_syntax noprefix

    # Stack frame
            .equ    x,-4
            .equ    localSize,-16
    # Useful constants
            .equ    ADDITION0,1000
            .equ    ADDITION1,2000
            .equ    INITx,78
            .equ    INITy,90
            .equ    INITn,0
    # Constant data
            .section  .rodata
            .align  8
    format0:
            .string "In addConst0:%8i %8i %8i  called %i times\n"
    format1:
            .string "In addConst1:%8i %8i %8i  called %i times\n"
    # Define static variables
            .data
            .align 4
            .type   y_addConst0, @object
    y_addConst0:
            .int    INITy
            .type   n_addConst0, @object
    n_addConst0:
            .int    INITn
            .type   y_addConst1, @object
    y_addConst1:
            .int    INITy
            .type   n_addConst1, @object
    n_addConst1:
            .int    INITn

    # Code
            .text
            .globl  addConst0
            .type   addConst0, @function
    addConst0:
            push    rbp           # save frame pointer
            mov     rbp, rsp      # set new frame pointer
            add     rsp, localSize  # for local var.
            mov     dword ptr x[rbp], INITx   # initialize

            inc     dword ptr n_addConst0[rip]
            add     dword ptr x[rbp], ADDITION0 # add to vars
            add     dword ptr y_addConst0[rip], ADDITION0
            add     dword ptr z[rip], ADDITION0

            mov     r8d, n_addConst0[rip]
            mov     ecx, z[rip]   # print variables
            mov     edx, y_addConst0[rip]
            mov     esi, x[rbp]
            lea     rdi, format0[rip]
            mov     eax, 0          # no floats
            call    printf@plt

            mov     eax, 0      # return 0;
            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # and caller frame pointer
            ret

            .globl  addConst1
            .type   addConst1, @function
    addConst1:
            push    rbp           # save frame pointer
            mov     rbp, rsp      # set new frame pointer
            add     rsp, localSize  # for local var.
            mov     dword ptr x[rbp], INITx   # initialize

            inc     dword ptr n_addConst1[rip]
            add     dword ptr x[rbp], ADDITION1 # add to vars
            add     dword ptr y_addConst1[rip], ADDITION1
            add     dword ptr z[rip], ADDITION1

            mov     r8d, n_addConst1[rip]
            mov     ecx, z[rip]   # print variables
            mov     edx, y_addConst1[rip]
            mov     esi, x[rbp]
            lea     rdi, format1[rip]
            mov     eax, 0          # no floats
            call    printf@plt

            mov     eax, 0      # return 0;
            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # and caller frame pointer
            ret
    ```
