---
layout: default
title: Chapter 16
---

## Chapter 16

### Page 343
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
    dowhileLoop:
            mov 	  al, byte ptr [rdi]  # char from source
            mov     byte ptr [rsi], al  # char to destination
            cmp     al, NUL             # was it the end?
            je      allDone             # yes, all done
            or      byte ptr [rsi], lowerMask # no, make sure it's lower
            inc     rdi         # increment
            inc     rsi         #      pointers
            inc     dword ptr count[rbp]    # and counter
            jmp     dowhileLoop # continue loop
    allDone:
            mov     eax, dword ptr count[rbp]   # return count

            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # and caller frame pointer
            ret
    ```

    ```asm
    # lowerCase.s
    # Makes user alphabetic text string all lowercase
            .intel_syntax noprefix
    # Stack frame
            .equ    myString,-64
            .equ    canary,-8
            .equ    localSize,-64
    # Useful constants
            .equ    MAX,50  # character buffer limit
            .equ    NUL,0
    # Constant data
            .section	.rodata
            .align 8
    prompt:
            .string	"Enter up to 50 alphabetic characters: "
    message:
            .string	"All lower: "
    newLine:
            .string	"\n"
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
            
            mov     esi, MAX    # limit user input
            lea     rdi, myString[rbp]  # place to store input
            call    readLn

            lea     rsi, myString[rbp]  # destination string
            lea     rdi, myString[rbp]  # source string
            call    toLower
            
            lea     rdi, message[rip]   # tell user
            call    writeStr

            lea     rdi, myString[rbp]  # result
            call    writeStr
            lea     rdi, newLine[rip]   # some formatting
            call    writeStr

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

2. 

    ```asm
    # changeCase.s
    # Changes user alphabetic text to opposite case
            .intel_syntax noprefix
    # Stack frame
            .equ    myString,-64
            .equ    canary,-8
            .equ    localSize,-64
    # Useful constants
            .equ    MAX,50  # character buffer limit
            .equ    NUL,0
    # Constant data
            .section	.rodata
            .align 8
    prompt:
            .string	"Enter up to 50 alphabetic characters: "
    message:
            .string	"Opposite case: "
    newLine:
            .string	"\n"
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
            
            mov     esi, MAX    # limit user input
            lea     rdi, myString[rbp]  # place to store input
            call    readLn

            lea     rsi, myString[rbp]  # destination string
            lea     rdi, myString[rbp]  # source string
            call    change
            
            lea     rdi, message[rip]   # tell user
            call    writeStr

            lea     rdi, myString[rbp]  # result
            call    writeStr
            lea     rdi, newLine[rip]   # some formatting
            call    writeStr

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
    # change.s
    # Changes case of alphabetic characters in a C string.
    # Calling sequence:
    #   rdi <- pointer to source string
    #   rsi <- pointer to destination string
    #   returns number of characters processed.
            .intel_syntax noprefix

    # Stack frame
            .equ    count,-4
            .equ    localSize,-16
    # Useful constants
            .equ    changeMask,0x20
            .equ    NUL,0
    # Code
            .text
            .globl  change
            .type   change, @function
    change:
            push    rbp         # save frame pointer
            mov     rbp, rsp    # set new frame pointer
            add     rsp, localSize      # for local var.
            
            mov     dword ptr count[rbp], 0
    dowhileLoop:
            mov 	  al, byte ptr [rdi]  # char from source
            mov     byte ptr [rsi], al  # char to destination
            cmp     al, NUL             # was it the end?
            je      allDone             # yes, all done
            xor     byte ptr [rsi], changeMask # no, change to other
            inc     rdi         # increment
            inc     rsi         #      pointers
            inc     dword ptr count[rbp]    # and counter
            jmp     dowhileLoop # continue loop
    allDone:
            mov     eax, dword ptr count[rbp]   # return count

            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # and caller frame pointer
            ret
    ```

3. The `main` function calls `toLower`, which is just above, and `toUpper`, which is Listing 16-6 in the book.

    ```asm
    # bothCases.s
    # Makes user alphabetic text string both cases
            .intel_syntax noprefix
    # Stack frame
            .equ    upperCase,-164
            .equ    lowerCase,-112
            .equ    myString,-60
            .equ    canary,-8
            .equ    localSize,-176
    # Useful constants
            .equ    upperMask,0xdf
            .equ    MAX,50  # character buffer limit
            .equ    NUL,0
    # Constant data
            .section	.rodata
            .align 8
    prompt:
            .string	"Enter up to 50 alphabetic characters: "
    upperMsg:
            .string	"All upper: "
    lowerMsg:
            .string	"All lower: "
    origMsg:
            .string	"Original: "
    newLine:
            .string	"\n"
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
            
            mov     esi, MAX    # limit user input
            lea     rdi, myString[rbp]  # place to store input
            call    readLn

            lea     rsi, upperCase[rbp] # destination string
            lea     rdi, myString[rbp]  # source string
            call    toUpper
            
            lea     rsi, lowerCase[rbp] # destination string
            lea     rdi, myString[rbp]  # source string
            call    toLower
            
            lea     rdi, upperMsg[rip]  # tell user
            call    writeStr
            lea     rdi, upperCase[rbp] # result
            call    writeStr
            lea     rdi, newLine[rip]   # some formatting
            call    writeStr

            lea     rdi, lowerMsg[rip]  # tell user
            call    writeStr
            lea     rdi, lowerCase[rbp] # result
            call    writeStr
            lea     rdi, newLine[rip]   # some formatting
            call    writeStr

            lea     rdi, origMsg[rip]   # tell user
            call    writeStr
            lea     rdi, myString[rbp]
            call    writeStr
            lea     rdi, newLine[rip]   # some formatting
            call    writeStr

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

### Page 351
1. 

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

2. When testing your solution, make sure to try `1777777777777777777777`. That's a `1` followed by 21 `7`s.

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
1. The `decToSInt` function in this program calls `decToUInt`, Listing 16-18 in the book.

    ```asm
    # convertSDec.s
            .intel_syntax noprefix
    # Stack frame
            .equ    myString,-48
            .equ    myInt, -12
            .equ    canary,-8
            .equ    localSize,-48
    # Useful constants
            .equ    MAX,11      # character buffer limit
    # Constant data
            .section	.rodata
            .align 8
    prompt:
            .string	"Enter a signed integer: "
    format:
            .string	"\"%s\" is stored as 0x%x\n"
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
            call    decToSInt

            mov     edx, myInt[rbp]     # converted value
            lea     rsi, myString[rbp]  # echo user input
            lea     rdi, format[rip]    # printf format string
            mov     eax, 0
            call	  printf
            
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
    # decToSInt.s
    # Converts string of numerals to signed decimal int

    # Calling sequence
    #       rsi <- address of place to store the int
    #       rdi <- address of string
    #       call decToSInt
    #       returns 0
            .intel_syntax noprefix

    # Stack frame
            .equ    negFlag,-4
            .equ    localSize,-16
    # Code
            .text
            .globl  decToSInt
            .type   decToSInt, @function
    decToSInt:
            push    rbp         # save frame pointer
            mov     rbp, rsp    # set new frame pointer
            add     rsp, localSize      # for local var.

            mov     dword ptr negFlag[rbp], 0   # assume false

            cmp     byte ptr [rdi], '-' # minus sign?
            jne     checkPlus   # no, check for plus sign
            mov     dword ptr negFlag[rbp], 1   # negFlag = true;
            inc     rdi         # skip minus sign
            jmp     doIt        # and do the conversion
    checkPlus:
            cmp     byte ptr [rdi], '+' # plus sign?
            jne     doIt        # no, ready for conversion
            inc     rdi         # skip plus sign
    doIt:
            call    decToUInt   # arguments are correct
                                # absolute value now stored
            cmp     byte ptr negFlag[rbp], 0    # negative?
            je      done        # no, all done
            neg     dword ptr [rsi]     # change sign
    done:
            mov     eax, 0      # return 0;
            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # and caller frame pointer
            ret
    ```

2. Use the `main` function in `convertDec.s`, Listing 16-17 in the book.

    ```asm
    # decToUIntNomul.s
    # Converts decimal character string to unsigned 32-bit int.
    # Calling sequence:
    #   rdi <- pointer to source string
    #   rsi <- pointer to int result
    #   returns 0
            .intel_syntax noprefix

    # Useful constants
            .equ    DECIMAL,10
            .equ    NUMMASK,0x0f
            .equ    NUL,0

    # Code
            .text
            .globl  decToUInt
            .type   decToUInt, @function
    decToUInt:
            push    rbp         # save frame pointer
            mov     rbp, rsp    # set new frame pointer

            mov     dword ptr [rsi], 0  # result = 0
            mov     al, byte ptr [rdi]  # get a char
    whileLoop:
            cmp     al, NUL     # end of string?
            je      allDone     # yes, all done
            and     eax, NUMMASK    # no, 4-bits -> 32-bit int
            mov     ecx, dword ptr [rsi]    # current result
            mov     edx, ecx    # get a copy
            sal     edx, 1      # X 2
            sal     ecx, 3      # X 8
            add     ecx, edx    # gives X 10
            add     ecx, eax    # add the new value
            mov     dword ptr [rsi], ecx    # update result
            inc     rdi         # increment string ptr
            mov     al, byte ptr [rdi]  # next char
            jmp     whileLoop   # and continue
    allDone:
            mov     dword ptr [rsi], ecx    # output result
            mov     eax, 0      # return 0

            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # and caller frame pointer
            ret
    ```

### Page 370
1. I modified the `main` function in Listing 16-23 in the book to test my `intToSDec` function.

    ```asm
    # intToSDec.s
    # Converts int to corresponding signed decimal string

    # Calling sequence
    #       esi <- value of the int
    #       rdi <- address of string
    #       call intToSDec
    #       returns zero
            .intel_syntax noprefix

    # Code
            .text
            .globl	intToSDec
            .type   intToSDec, @function
    intToSDec:
            push    rbp         # save frame pointer
            mov     rbp, rsp    # set new frame pointer

            cmp     esi, 0      # >= 0?
            jge     positive    # yes, just convert it
            mov     byte ptr [rdi], '-' # store minus sign
            inc     rdi         # and move the pointer
            neg     esi         # negate the number
    positive:
            call    intToUDec   # rest is unsigned
      
            mov     eax, 0      # return 0;
            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # and caller frame pointer
            ret
    ```
    ```asm
    # sAdd123.s
    # Adds 123 to an int.
            .intel_syntax noprefix
    # Stack frame
            .equ    myString,-32
            .equ    myInt, -12
            .equ    canary,-8
            .equ    localSize,-32
    # Useful constants
            .equ    MAX,12      # character buffer limit
    # Constant data
            .section	.rodata
            .align 8
    prompt:
            .string	"Enter a signed integer: "
    message:
            .string	"The result is: "
    endl:
            .string "\n"
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
            call    decToSInt

            mov     eax, dword ptr myInt[rbp]
            add     eax, 123
            mov     dword ptr myInt[rbp], eax

            mov     esi, myInt[rbp]     # the number
            lea     rdi, myString[rbp]  # place for string
            call    intToSDec
            
            lea     rdi, message[rip]   # message for user
            call    writeStr
            
            lea     rdi, myString[rbp]  # number in text
            call    writeStr
            
            lea     rdi, endl[rip]
            call    writeStr

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

2. To test the `putInt` and `getInt` functions, I wrote a `main` function that adds 345 to the integer input by the user. Notice that `putInt` calls `intToSDec`, which in turn calls `intToUDec`, so you have to include these function in your linking command. Likewise, you need to also include `decToSInt` and `decToUInt` for `getInt` in your linking.

    ```asm
    # putInt.s
    # writes a signed int to standard out

    # Calling sequence
    #       edi <- value of the int
    #       call putInt
            .intel_syntax noprefix

    # Stack frame
            .equ    canary,-8
            .equ    buffer,-20
            .equ    localSize,-32
    # Code
            .text
            .globl  putInt
            .type   putInt, @function
    putInt:
            push    rbp             # save frame pointer
            mov     rbp, rsp        # set new frame pointer
            add     rsp, localSize  # for local var.
            mov     rax, fs:40      # get canary
            mov     canary[rbp], rax  #   and save

            mov     esi, edi        # number to convert
            lea     rdi, buffer[rbp]  # place to store string
            call    intToSDec   # do the conversion to string
            
            lea     rdi, buffer[rbp]  # place where string stored
            call    writeStr    # write it
            
            mov     eax, 0
            mov     rsi, canary[rbp]
            xor     rsi, fs:40
            je      stackGood
            call    __stack_chk_fail@plt
    stackGood:
            mov     rsp, rbp        # restore stack pointer
            pop     rbp             # and caller frame pointer
            ret
    ```
    ```asm
    # getInt.s
    # reads an int from standard in

    # Calling sequence
    #       rdi <- pointer where to store the int
    #       call getInt
    #       returns 0
            .intel_syntax noprefix

    # Useful contant
            .equ    MAX, 12  # includes NUL char and sign
    # Stack frame
            .equ    canary,-8
            .equ    outPtr,-16
            .equ    buffer,-32
            .equ    localSize,-32
    # Code
            .text
            .globl  getInt
            .type   getInt, @function
    getInt:
            push    rbp             # save frame pointer
            mov     rbp, rsp        # set new frame pointer
            add     rsp, localSize  # for local var.
            mov     rax, fs:40      # get canary
            mov     canary[rbp], rax  #   and save
            
            mov     outPtr[rbp], rdi    # save argument

            mov     esi, MAX    # max number of chars
            lea     rdi, buffer[rbp]    # place where string stored
            call    readLn  # read it
            
            mov     rsi, outPtr[rbp]    # place to store number
            lea     rdi, buffer[rbp]    # address of string
            call    decToSInt   # convert string to int
            
            mov     eax, 0
            mov     rsi, canary[rbp]
            xor     rsi, fs:40
            je      stackGood
            call    __stack_chk_fail@plt
    stackGood:
            mov     rsp, rbp        # restore stack pointer
            pop     rbp             # and caller frame pointer
            ret
    ```
    ```asm
    # add345.s
    # Adds 345 to integer input by user.
            .intel_syntax noprefix

    # Stack frame
    #   local vars (rbp)
            .equ    myInt,-4
            .equ    localSize,-16
    # Read only data
            .section  .rodata
    prompt:
            .string "Enter an integer: "
    newLine:
            .string "\n"
    # Code
            .text
            .globl  main
            .type   main, @function
    main:
            push    rbp             # save frame pointer
            mov     rbp, rsp        # set new frame pointer
            add     rsp, localSize  # for local var.
            
            lea     rdi, prompt[rip]    # prompt user
            call    writeStr
            
            lea     rdi, myInt[rbp]
            call    getInt
            
            mov     edi, myInt[rbp]
            add     edi, 345
            call    putInt
            
            lea     rdi, newLine[rip]   # some formatting
            call    writeStr

            mov     eax, 0
            mov     rsp, rbp        # restore stack pointer
            pop     rbp             # and caller frame pointer
            ret
    ```

3. The `main` function in this program uses the `putInt` and 'getInt` functions that we wrote in the previous exercise.

    ```asm
    # fourFunctions.s
    # Gets two integers, adds, subtracts, mutliplies
    # and divides them.
            .intel_syntax noprefix

    # Stack frame
    #   local vars (rbp)
            .equ    xInt,-4
            .equ    yInt,-8
            .equ    rem,-12
            .equ    localSize,-16
    # Read only data
            .section  .rodata
    prompt:
            .string "Enter an integer: "
    sum:
            .string "Sum = "
    diff:
            .string "Difference = "
    prod:
            .string "Product = "
    quot:
            .string "Quotient = "
    remain:
            .string " with Remainder = "
    newLine:
            .string "\n"
    # Code
            .text
            .globl  main
            .type   main, @function
    main:
            push    rbp             # save frame pointer
            mov     rbp, rsp        # set new frame pointer
            add     rsp, localSize  # for local var.
            
            lea     rdi, prompt[rip]    # first integer
            call    writeStr
            
            lea     rdi, xInt[rbp]
            call    getInt
            
            lea     rdi, prompt[rip]    # second integer
            call    writeStr
            
            lea     rdi, yInt[rbp]
            call    getInt
            
            lea     rdi, sum[rip]       # prompt user
            call    writeStr        
            mov     edi, xInt[rbp]
            add     edi, yInt[rbp]
            call    putInt        
            lea     rdi, newLine[rip]   # some formatting
            call    writeStr

            lea     rdi, diff[rip]    # prompt user
            call    writeStr        
            mov     edi, xInt[rbp]
            sub     edi, yInt[rbp]
            call    putInt        
            lea     rdi, newLine[rip]   # some formatting
            call    writeStr

            lea     rdi, prod[rip]    # prompt user
            call    writeStr        
            mov     edi, xInt[rbp]
            imul    edi, yInt[rbp]
            call    putInt        
            lea     rdi, newLine[rip]   # some formatting
            call    writeStr

            lea     rdi, quot[rip]    # prompt user
            call    writeStr  
            mov     edx, 0      
            mov     eax, xInt[rbp]
            idiv    dword ptr yInt[rbp]
            mov     rem[rbp], edx
            mov     edi, eax
            call    putInt        

            lea     rdi, remain[rip]    # prompt user
            call    writeStr        
            mov     edi, rem[rbp]
            call    putInt        
            lea     rdi, newLine[rip]   # some formatting
            call    writeStr

            mov     eax, 0
            mov     rsp, rbp        # restore stack pointer
            pop     rbp             # and caller frame pointer
            ret
    ```