---
layout: default
title: Chapter 19
---

## Chapter 19

### Page 424
1. Scaling by sixteen.
 
    ```
    (gdb) l
    1	# rulerAdd.s
    2	# Adds two ruler measurements, to nearest 1/16 inch.
    3	        .intel_syntax noprefix
    4	# Stack frame
    5	        .equ    x,-16
    6	        .equ    y, -12
    7	        .equ    canary,-8
    8	        .equ    localSize,-16
    9	# Constant data
    10	        .section	.rodata
    (gdb) 
    11	        .align 8
    12	endl:
    13	        .string "\n"
    14	# Code
    15	        .text
    16	        .globl	main
    17	        .type	main, @function
    18	main:
    19	        push    rbp         # save frame pointer
    20	        mov     rbp, rsp    # set new frame pointer
    (gdb) 
    21	        add     rsp, localSize  # for local var.
    22	        mov     rax, qword ptr fs:40    # get canary
    23	        mov     qword ptr canary[rbp], rax
    24	
    25	        lea     rdi, x[rbp] # x length
    26	        call    getLength
    27	        
    28	        lea     rdi, y[rbp] # y length
    29	        call    getLength
    30	
    (gdb) 
    31	        mov     edi, x[rbp] # retrieve x length
    32	        add     edi, y[rbp] # add y length
    33	        call    displayLength
    34	
    35	        mov     eax, 0      # return 0;
    36	        mov     rcx, qword ptr canary[rbp]
    37	        xor     rcx, qword ptr fs:40
    38	        je      allOK
    39	        call    __stack_chk_fail@plt
    40	allOK:
    (gdb) b 26
    Breakpoint 1 at 0x1172: file rulerAdd.s, line 26.
    (gdb) b 29
    Breakpoint 2 at 0x117b: file rulerAdd.s, line 29.
    (gdb) b 31
    Breakpoint 3 at 0x1180: file rulerAdd.s, line 31.
    (gdb) r
    Starting program: /home/bob/NoStarch/x-86/progs/working/chapter_19/Your_Turn/rulerAdd_fixed/rulerAdd 

    Breakpoint 1, main () at rulerAdd.s:26
    26	        call    getLength
    (gdb) i r rdi
    rdi            0x7fffffffde80      140737488346752
    (gdb) c
    Continuing.
    Enter inches and 1/16s
            Inches: 12
        Sixteenths: 3

    Breakpoint 2, main () at rulerAdd.s:29
    29	        call    getLength
    (gdb) i r rdi
    rdi            0x7fffffffde84      140737488346756
    (gdb) c
    Continuing.
    Enter inches and 1/16s
            Inches: 45
        Sixteenths: 6

    Breakpoint 3, main () at rulerAdd.s:31
    31	        mov     edi, x[rbp] # retrieve x length
    (gdb) x/2wx 0x7fffffffde80
    0x7fffffffde80:	0x000000c3	0x000002d6
    ```

   When we examine memory where the x and y variables are stored, we can see that 3 is stored in the low-order 4 bits of `x`, and 12 (`0xc`) is stored in the high-order 28 bits. Similarly, 45 (`0x2d`) and 6 are stored in `y`.
2. Scaling by ten.

    ```
    (gdb) l
    1	# moneyAdd.s
    2	# Adds two money amounts in dollars and cents.
    3	        .intel_syntax noprefix
    4	# Stack frame
    5	        .equ    x,-16
    6	        .equ    y, -12
    7	        .equ    canary,-8
    8	        .equ    localSize,-16
    9	# Constant data
    10	        .section	.rodata
    (gdb) 
    11	        .align 8
    12	endl:
    13	        .string "\n"
    14	# Code
    15	        .text
    16	        .globl	main
    17	        .type	main, @function
    18	main:
    19	        push    rbp         # save frame pointer
    20	        mov     rbp, rsp    # set new frame pointer
    (gdb) 
    21	        add     rsp, localSize  # for local var.
    22	        mov     rax, qword ptr fs:40    # get canary
    23	        mov     qword ptr canary[rbp], rax
    24	
    25	        lea     rdi, x[rbp] # x amount
    26	        call    getMoney
    27	        
    28	        lea     rdi, y[rbp] # y amount
    29	        call    getMoney
    30	
    (gdb) 
    31	        mov     edi, x[rbp] # retrieve x amount
    32	        add     edi, y[rbp] # add y amount
    33	        call    displayMoney
    34	
    35	        mov     eax, 0      # return 0;
    36	        mov     rcx, qword ptr canary[rbp]
    37	        xor     rcx, qword ptr fs:40
    38	        je      allOK
    39	        call    __stack_chk_fail@plt
    40	allOK:
    (gdb) b 26
    Breakpoint 1 at 0x1172: file moneyAdd.s, line 26.
    (gdb) b 29
    Breakpoint 2 at 0x117b: file moneyAdd.s, line 29.
    (gdb) b 31
    Breakpoint 3 at 0x1180: file moneyAdd.s, line 31.
    (gdb) r
    Starting program: /home/bob/NoStarch/x-86/progs/working/chapter_19/Your_Turn/moneyAdd_fixed/moneyAdd 

    Breakpoint 1, main () at moneyAdd.s:26
    26	        call    getMoney
    (gdb) i r rdi
    rdi            0x7fffffffde40      140737488346688
    (gdb) c
    Continuing.
    Enter amount
        Dollars: 12
          Cents: 30

    Breakpoint 2, main () at moneyAdd.s:29
    29	        call    getMoney
    (gdb) i r rdi
    rdi            0x7fffffffde44      140737488346692
    (gdb) c
    Continuing.
    Enter amount
        Dollars: 45
          Cents: 60

    Breakpoint 3, main () at moneyAdd.s:31
    31	        mov     edi, x[rbp] # retrieve x amount
    (gdb) x/2wd 0x7fffffffde40
    0x7fffffffde40:	1230	4560
    (gdb) x/2wx 0x7fffffffde40
    0x7fffffffde40:	0x000004ce	0x000011d0
    (gdb) 
    ```
   
   In this program, we've scaled the dollar values by 100. So when we examine memory where `x` and `y` are stored, we see the integers 1230 (`0x000004cd`) and 4560 (`0x000011d0`) for 12.30 and 45.60, respectively. Note that the integral and fractional parts are not separated by bit boundaries since we're not scaling by a multiple of 2.

3. Limited number of bits.

    ```
    Enter amount
        Dollars: 42949672   
          Cents: 95
    Enter amount
        Dollars: 0
          Cents: 1
    Total = $0.0
    ```

   We can explore the limit:

    ```
Enter amount
    Dollars: 429495672
      Cents: 94
Enter amount
    Dollars: 0
      Cents: 1
Total = $42948616.31
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

