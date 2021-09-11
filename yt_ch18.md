---
layout: default
title: Chapter 18
---

## Chapter 18

### Page 405
1. We first add the prototype for our second constructor to our class.
 
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
   Then we define the new constructor.

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


### Page 407
1. First, we remove the constructor and destructor from our class declaration.

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
        int num;               // numerator
        int den;               // denominator
      public:
        void get();               // gets user's values
        void display();           // displays fraction
        void add(int theValue);   // adds integer
    };
    #endif
    ```

   And we remove their defintions.

    ```cpp
    // fraction.cpp
    // Simple fraction class

    #include "fraction.hpp"
    // Use char arrays because writeStr is C function.
    char numMsg[] = "Enter numerator: ";
    char denMsg[] = "Enter denominator: ";
    char over[] = "/";
    char endl[] = "\n";

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
    ```

   When I ran this program, I got garbage values for the fraction before entering my own valued. Looking at the compiler-generated assembly language, we see that it allocates memory on the stack for the object but never initializes it.

    ```
            .file   "incFraction.cpp"
            .intel_syntax noprefix
            .text
            .globl  main
            .type   main, @function
    main:
            push    rbp
            mov     rbp, rsp
            sub     rsp, 16                 ## memory for the object and the stack canary
            mov     rax, QWORD PTR fs:40
            mov     QWORD PTR -8[rbp], rax  ## address of the stack canary
            xor     eax, eax
            lea     rax, -16[rbp]           ## address of the object
            mov     rdi, rax
            call    _ZN8fraction7displayEv@PLT
            lea     rax, -16[rbp]
            mov     rdi, rax
            call    _ZN8fraction3getEv@PLT
            lea     rax, -16[rbp]
            mov     esi, 1
            mov     rdi, rax
            call    _ZN8fraction3addEi@PLT
            lea     rax, -16[rbp]
            mov     rdi, rax
            call    _ZN8fraction7displayEv@PLT
            mov     eax, 0
            mov     rdx, QWORD PTR -8[rbp]
            xor     rdx, QWORD PTR fs:40
            je      .L3
            call    __stack_chk_fail@PLT
    .L3:
            leave
            ret
            .size   main, .-main
            .ident  "GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
            .section        .note.GNU-stack,"",@progbits
    ```

### Page 412
1. This is a display issue, so the only member function that needs to be changed is `fraction_display`.

    ```asm
      # fraction_display.s
      # Displays fraction
      # Calling sequence:
      #   rdi <- address of object
              .intel_syntax noprefix
              .include    "fraction"
      # Text for fraction_display
              .data
      over:
              .string "/"
      ampersand:
              .string " & "
      endl:
              .string "\n"
      # Stack frame
              .equ    this,-16
              .equ    rem,-8
              .equ    localSize,-16
      # Code
              .text
              .globl  fraction_display
              .type   fraction_display, @function
      fraction_display:
              push    rbp         # save frame pointer
              mov     rbp, rsp    # set new frame pointer
              add     rsp, localSize  # for local var.
              mov     this[rbp], rdi  # this pointer

              mov     r11, this[rbp]  # load this pointer
              mov     eax, num[r11]   # numerator
              mov     edx, 0          # zero high-order
              div     dword ptr den[r11]
              mov     rem[rbp], edx   # save remainder
              mov     edi, eax        # print quotient
              call    putInt

              lea     rdi, ampersand[rip]  # and
              call    writeStr
              
              mov     edi, rem[rbp]   # remainder
              call    putInt
              lea     rdi, over[rip]  # slash
              call    writeStr

              mov     r11, this[rbp]  # load this pointer
              mov     edi, den[r11]
              call    putInt
              
              lea     rdi, endl[rip]  # newline
              call    writeStr

              mov     rsp, rbp    # restore stack pointer
              pop     rbp         # and caller frame pointer
              ret
    ```

