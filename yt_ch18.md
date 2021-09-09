---
layout: default
title: Chapter 18
---

## Chapter 18

### Page 405
1. We first add the prototype for our second constructor.
 
    ```cpp
    // fraction.hpp
    // simple fraction class

    #ifndef FRACTION_HPP
    #define FRACTION_HPP
    // Uses the following C functions
    extern "C" int writeStr(char *);
    extern "C" int getInt(int *);
    extern "C" int putInt(int);

    class fraction
    {
        int num;
        int den;
      public:
        fraction();                 // default constructor
        fraction(int x, int y);     // another constructor
        ~fraction();                // destructor
        void get();                 // gets user's values
        void display();             // displays fraction
        void add(int theValue);     // adds theValue
    };
    #endif
    ```

    ```cpp
    ```
    // fraction.cpp
    // Simple fraction class

    #include "fraction.hpp"
    // Use char arrays because writeStr is C function.
    char numMsg[] = "Enter numerator: ";
    char denMsg[] = "Enter denominator: ";
    char over[] = "/";
    char endl[] = "\n";

    fraction::fraction()
    {
      num = 0;
      den = 1;
    }

    fraction::fraction(int top, int bottom)
    {
      num = top;
      den = bottom;
    }

    fraction::~fraction()
    {
      // Nothing to do for this object
    }

    void fraction::get()
    {
      writeStr(numMsg);   
      getInt(&num);
      
      writeStr(denMsg);
      getInt(&den);
    }

    void fraction::display()
    {
      putInt(num);
      writeStr(over);
      putInt(den);
      writeStr(endl);
    }

    void fraction::add(int theValue)
    {
      num += theValue * den;
    }

    ```cpp
    // inc2Fractions.cpp
    // Gets twp fractions from user and increments each by one

    #include "fraction.hpp"

    int main(void)
    {
      fraction x;
      x.display();
      x.get();
      x.add(1);
      x.display();

      fraction y(1,2);
      y.display();
      y.get();
      y.add(1);
      y.display();

      return 0;
    }
    ```


### Page 393
1. The effects of this change are easiest to see in the `displayRecord` function. The version in Listing 17-18 copies the twelve bytes that make up the record that is passed to it by value (my comments follow ##):

    ```asm
            mov     QWORD PTR -16[rbp], rdx ## 8 bytes of record
            mov     DWORD PTR -8[rbp], eax  ## another 4 bytes
            movzx   eax, BYTE PTR -8[rbp]   ## load anotherChar
            movsx   ecx, al                 ## extend to 32 bits
            mov     edx, DWORD PTR -12[rbp] ## load anInt
            movzx   eax, BYTE PTR -16[rbp]  ## load aChar
            movsx   eax, al                 ## extend to 32 bits
    ```

   But placing the two `char` elements adjacent to each other reduces the size of the record from twelve to eight bytes:

    ```asm
            mov     QWORD PTR -8[rbp], rdi  ## 8 bytes of record
            movzx   eax, BYTE PTR -7[rbp]   ## load anotherChar
            movsx   ecx, al                 ## extend to 32 bits
            mov     edx, DWORD PTR -4[rbp]  ## load anInt
            movzx   eax, BYTE PTR -8[rbp]   ## load aChar
            movsx   eax, al                 ## extend to 32 bits
    ```

   We can verify the placement of the value in the record using `gdb`:

    ```
    (gdb) l displayRecord
    4	
    5	#include <stdio.h>
    6	#include "displayRecord.h"
    7	
    8	void displayRecord(struct aTag aRecord)
    9	{
    10	  printf("%c, %i, %c\n", aRecord.aChar,
    11	         aRecord.anInt, aRecord.anotherChar);
    12	}
    13	
    (gdb) b 10
    Breakpoint 1 at 0x1240: file displayRecord.c, line 10.
    (gdb) r
    Starting program: /home/bob/chapter_17/Your_Turn/recordPassAdj_C/records 

    Breakpoint 1, displayRecord (aRecord=...) at displayRecord.c:10
    10	  printf("%c, %i, %c\n", aRecord.aChar,
    (gdb) i r rbp
    rbp            0x7fffffffde60      0x7fffffffde60
    (gdb) x/8xb 0x7fffffffde58
    0x7fffffffde58:	0x61	0x62	0x55	0x55	0x7b	0x00	0x00	0x00
    ```

   Here we see `aChar` at location `0x7fffffffde58`, `anotherChar` at `0x7fffffffde59`, and `anInt` at `0x7fffffffde5c` (in little endian order). The two bytes at `0x7fffffffde5a` and `0x7fffffffde5b` are garbage values.

    ```
    (gdb) c
    Continuing.
    a, 123, b

    Breakpoint 1, displayRecord (aRecord=...) at displayRecord.c:10
    10	  printf("%c, %i, %c\n", aRecord.aChar,
    (gdb) x/8xb 0x7fffffffde58
    0x7fffffffde58:	0x31	0x32	0xff	0xff	0xc8	0x01	0x00	0x00
    (gdb) c
    Continuing.
    1, 456, 2
    [Inferior 1 (process 3155) exited normally]
    (gdb) 
    ```

   And when `displayRecord` is called with `y`, we see its values stored at the same locations.

2. When we pass by pointer, `displayRecord` loads the data from the calling function's copy of the record rather than make its own copy. As usual, I've added my own comments (##) to the compiler's assembly language to explain things.

    ```asm
            .file   "displayRecord.c"
            .intel_syntax noprefix
            .text
            .section        .rodata
    .LC0:
            .string "%c, %i, %c\n"
            .text
            .globl  displayRecord
            .type   displayRecord, @function
    displayRecord:
            push    rbp
            mov     rbp, rsp
            sub     rsp, 16
            mov     QWORD PTR -8[rbp], rdi  ## save address of record
            mov     rax, QWORD PTR -8[rbp]  ## load address of record
            movzx   eax, BYTE PTR 8[rax]    ## load anotherChar
            movsx   ecx, al                 ## extend to 32 bits
            mov     rax, QWORD PTR -8[rbp]  ## load address of record
            mov     edx, DWORD PTR 4[rax]   ## load anInt
            mov     rax, QWORD PTR -8[rbp]  ## load address of record
            movzx   eax, BYTE PTR [rax]     ## load aChar
            movsx   eax, al                 ## extend to 32 bits
            mov     esi, eax
            lea     rdi, .LC0[rip]
            mov     eax, 0
            call    printf@PLT
            nop
            leave
            ret
            .size   displayRecord, .-displayRecord
            .ident  "GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
            .section        .note.GNU-stack,"",@progbits
    ```

