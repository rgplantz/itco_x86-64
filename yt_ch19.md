---
layout: default
title: Chapter 19
---

## Chapter 19

### Page 425
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

   We can see that the scaled sum, 4294967296, exceeds 32 bits, causing the value to wrap around. Let's explore the limit:

    ```
    Enter amount
        Dollars: 42949672
          Cents: 94
    Enter amount
        Dollars: 0
          Cents: 1
    Total = $42949672.95
    ```

   Now the scaled sum, 4294967295, fits within 32 bits.

4. This is a little tricky. I used my signed `getInt` function to read the input numbers. But I found it easier to use my unsigned `putUInt` function to display the numbers and deal with the sign in a `displaySMoney` function because I didn't want to display a negative amount like $-123.-45. My solution would display this like -$123.45, which I think you'll agree is much better.

    ```asm
    # moneySAdd.s
    # Adds two money amounts in dollars and cents.
            .intel_syntax noprefix
    # Stack frame
            .equ    x,-16
            .equ    y, -12
            .equ    canary,-8
            .equ    localSize,-16
    # Constant data
            .section	.rodata
            .align 8
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

            lea     rdi, x[rbp] # x amount
            call    getSMoney
            
            lea     rdi, y[rbp] # y amount
            call    getSMoney

            mov     edi, x[rbp] # retrieve x amount
            add     edi, y[rbp] # add y amount
            call    displaySMoney

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
    # getSMoney.s
    # Gets money in dollars and cents.
    # Outputs 32-bit value, money in cents.
    # Calling sequence:
    #   rdi <- pointer to length
            .intel_syntax noprefix
    # Useful constant
            .equ    dollar2cents, 100
    # Stack frame
            .equ    moneyPtr,-16
            .equ    dollars,-8
            .equ    cents,-4
            .equ    localSize,-16
    # Constant data
            .section	.rodata
            .align 8
    prompt:
            .string "Enter amount\n"
    dollarsPrompt:
            .string "    Dollars: "
    centsPrompt:
            .string "      Cents: "
    # Code
            .text
            .globl  getSMoney
            .type   getSMoney, @function
    getSMoney:
            push    rbp         # save frame pointer
            mov     rbp, rsp    # set new frame pointer
            add     rsp, localSize  # for local var.
            
            mov     moneyPtr[rbp], rdi  # save pointer to output

            lea     rdi, prompt[rip]    # prompt user
            call    writeStr

            lea     rdi, dollarsPrompt[rip] # ask for dollars
            call    writeStr
            lea     rdi, dollars[rbp]   # get dollars
            call    getInt
            lea     rdi, centsPrompt[rip] # ask for cents
            call    writeStr
            lea     rdi, cents[rbp]     # get cents
            call    getInt
            
            mov     eax, dword ptr dollars[rbp] # retrieve dollars
            mov     ecx, dollar2cents   # scale dollars
            mul     ecx                 #          to cents
            mov     ecx, dword ptr cents[rbp]   # retrieve cents
            add     eax, ecx            # add in cents
            mov     rcx, moneyPtr[rbp]  # load pointer to output
            mov     [rcx], eax  # output

            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # and caller frame pointer
            ret
    ```

    ```asm
    # displaySMoney.s
    # Displays money in dollars and cents, signed.
    # Calling sequence:
    #   edi <- money in cents
            .intel_syntax noprefix
    # Useful constant
            .equ    cent2dollars, 100
    # Stack frame
            .equ    money,-16
            .equ    localSize,-16
    # Constant data
            .section	.rodata
            .align 8
    decimal:
            .string "."
    zero:
            .string "0"
    msg:
            .string "Total = $"
    msgNeg:
            .string "Total = -$"
    endl:
            .string "\n"
    # Code
            .text
            .globl  displaySMoney
            .type   displaySMoney, @function
    displaySMoney:
            push    rbp         # save frame pointer
            mov     rbp, rsp    # set new frame pointer
            add     rsp, localSize  # for local var.
            
            mov     money[rbp], edi # save input money
            cmp     dword ptr money[rbp], 0 # negative?
            jge     positive        # no
            lea     rdi, msgNeg[rip]      # yes, print minus sign
            call    writeStr
            neg     dword ptr money[rbp]  # work with positive
            jmp     showNumbers
    positive:
            lea     rdi, msg[rip]   # nice message
            call    writeStr
    showNumbers:        
            mov     edx, 0      # clear high order
            mov     eax, money[rbp]   # convert money amount
            mov     ecx, cent2dollars #     to dollars and cents
            div     ecx
            mov     money[rbp], edx # save cents

            mov     edi, eax    # dollars
            call    putUInt     # write to screen

            lea     rdi, decimal[rip] # decimal point
            call    writeStr
            
            cmp     dword ptr money[rbp], 10  # 2 decimal places?
            jae     twoDecimal      # yes
            lea     rdi, zero[rip]  # no, 0 in tenths place
            call    writeStr
    twoDecimal:
            mov     edi, money[rbp]    # load cents
            call    putUInt     # write to screen

            lea     rdi, endl[rip]
            call    writeStr

            mov     rsp, rbp    # restore stack pointer
            pop     rbp         # and caller frame pointer
            ret
    ```

### Page 435
1. We had to convert from `float` to `double` in the `addFloats` program because `scanf` and `printf` work with `double`s. We won't need to do the conversions in `addDoubles`, which simplifies the computation algorithm.

    ```asm
    # addDoubles.s
    # Adds two doubles.
            .intel_syntax noprefix
    # Stack frame
            .equ    x,-32
            .equ    y, -24
            .equ    canary,-8
            .equ    localSize,-32
    # Constant data
            .section	.rodata
    prompt:
            .string "Enter a number: "
    scanFormat:
            .string "%lf"
    printFormat:
            .string "%lf + %lf = %lf\n"
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

            lea     rdi, prompt[rip]  # prompt for input
            mov     eax, 0
            call    printf@plt
            lea     rsi, x[rbp]       # read x
            lea     rdi, scanFormat[rip]
            mov     eax, 0
            call    __isoc99_scanf@plt
            
            lea     rdi, prompt[rip]  # prompt for input
            mov     eax, 0
            call    printf@plt
            lea     rsi, y[rbp]       # read y
            lea     rdi, scanFormat[rip]
            mov     eax, 0
            call    __isoc99_scanf@plt
            
            movsd   xmm0, x[rbp]    # load x
            movsd   xmm1, y[rbp]    # load y
            movsd   xmm2, xmm0      # compute
            addsd   xmm2, xmm1      #     x + y
            lea     rdi, printFormat[rip]
            mov     eax, 3          # 3 xmm regs.
            call    printf@plt

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

   When I ran this program, it appears that converting to `double` is more accurate:

    ```
    Enter a number: 123.4
    Enter a number: 567.8
    123.400000 + 567.800000 = 691.200000
    ```

   However, examining the values in `gdb` shows that the numbers are not exact:

    ```
    Enter a number: 123.4
    Enter a number: 567.8

    Breakpoint 1, main () at addDoubles.s:50
    50	        call    printf@plt
    (gdb) p $xmm0.v2_double
    $1 = {123.40000000000001, 0}
    (gdb) p $xmm1.v2_double
    $2 = {567.79999999999995, 0}
    (gdb) p $xmm2.v2_double
    $3 = {691.19999999999993, 0}
    (gdb) c
    Continuing.
    123.400000 + 567.800000 = 691.200000
    ```

   `printf` rounds the numbers for display, which makes the results look exact. The errors may not matter in many applications, but they can cause errors in intermediate computations that can be very difficult to debug.

2. An attempt to divide by zero will cause an exception in the CPU, which the operating system will handle. This will be discussed in Chapter 21.

    ```asm
    # divideFloats.s
    # Divides float by another.
            .intel_syntax noprefix
    # Stack frame
            .equ    x,-20
            .equ    y,-16
            .equ    z,-12
            .equ    canary,-8
            .equ    localSize,-32
    # Constant data
            .section	.rodata
    prompt:
            .string "Enter a number: "
    scanFormat:
            .string "%f"
    printFormat:
            .string "%f / %f = %f\n"
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

            lea     rdi, prompt[rip]  # prompt for input
            mov     eax, 0
            call    printf@plt
            lea     rsi, x[rbp]       # read x
            lea     rdi, scanFormat[rip]
            mov     eax, 0
            call    __isoc99_scanf@plt
            
            lea     rdi, prompt[rip]  # prompt for input
            mov     eax, 0
            call    printf@plt
            lea     rsi, y[rbp]       # read y
            lea     rdi, scanFormat[rip]
            mov     eax, 0
            call    __isoc99_scanf@plt
            
            movss   xmm2, x[rbp]    # load x
            divss   xmm2, y[rbp]    # compute
            movss   z[rbp], xmm2    #     x + y
            cvtss2sd   xmm0, x[rbp] # convert to double
            cvtss2sd   xmm1, y[rbp] # convert to double
            cvtss2sd   xmm2, z[rbp] # convert to double
            lea     rdi, printFormat[rip]
            mov     eax, 3          # 3 xmm regs.
            call    printf@plt

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

   Running this program gave me:

    ```
    $ ./divideFloats 
    Enter a number: 123
    Enter a number: 0
    123.000000 / 0.000000 = inf
    ```

   So the operating system gave me a well-controlled response.   

3. We can tell the CPU to use the operating system's generic error handler.

    ```asm
    # divideFloats.s
    # Divides float by another.
            .intel_syntax noprefix
    # Useful constant
            .equ    noZM, 0xfffffdff
    # Stack frame
            .equ    mxcsrSave,-24
            .equ    x,-20
            .equ    y,-16
            .equ    z,-12
            .equ    canary,-8
            .equ    localSize,-32
    # Constant data
            .section	.rodata
    prompt:
            .string "Enter a number: "
    scanFormat:
            .string "%f"
    printFormat:
            .string "%f / %f = %f\n"
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

            lea     rdi, prompt[rip]  # prompt for input
            mov     eax, 0
            call    printf@plt
            lea     rsi, x[rbp]       # read x
            lea     rdi, scanFormat[rip]
            mov     eax, 0
            call    __isoc99_scanf@plt
            
            lea     rdi, prompt[rip]  # prompt for input
            mov     eax, 0
            call    printf@plt
            lea     rsi, y[rbp]       # read y
            lea     rdi, scanFormat[rip]
            mov     eax, 0
            call    __isoc99_scanf@plt
            
            stmxcsr mxcsrSave[rbp]
            and     dword ptr mxcsrSave[rbp], noZM
            ldmxcsr mxcsrSave[rbp]
            
            movss   xmm2, x[rbp]    # load x
            divss   xmm2, y[rbp]    # compute
            movss   z[rbp], xmm2    #     x + y
            cvtss2sd   xmm0, x[rbp] # convert to double
            cvtss2sd   xmm1, y[rbp] # convert to double
            cvtss2sd   xmm2, z[rbp] # convert to double
            lea     rdi, printFormat[rip]
            mov     eax, 3          # 3 xmm regs.
            call    printf@plt

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

   Running this program gave me:

    ```
    $ ./divideFloats 
    Enter a number: 123
    Enter a number: 0
    Floating point exception (core dumped)
    ```

   The message from the operating system was more generic in this case.   

### Page 439
1. This exercise further demonstrates the dangers of using floating-point numbers. Everything looks okay in the display, but bugs can lurk in intermediate arithmetic results.

    ```c
    /* threeDoubles.c
    * Associativity of doubles.
    */

    #include <stdio.h>
    #include <math.h>

    int main()
    {
      double x, y, z, sum1, sum2;

      printf("Enter a number: ");
      scanf("%lf", &x);
      printf("Enter a number: ");
      scanf("%lf", &y);
      printf("Enter a number: ");
      scanf("%lf", &z);
      
      sum1 = x + y;
      sum1 += z;      /* sum1 = (x + y) + z */
      sum2 = y + z;
      sum2 += x;      /* sum2 = x + (y + z) */

      if (sum1 == sum2)
        printf("%lf is the same as %lf\n", sum1, sum2);
      else
        printf("%lf is not the same as %lf\n", sum1, sum2);

      return 0;
    }
    ```

   The numbers appear to be associative, but the program says not:

    ```
    Enter a number: 1.1
    Enter a number: 1.2
    Enter a number: 1.3
    3.600000 is not the same as 3.600000
    ```

   Looking at the values in `gdb` shows is that it's not associative, but the rounding off done by `printf` makes it look so:
   
    ```
    (gdb) l 20
    15	  scanf("%lf", &y);
    16	  printf("Enter a number: ");
    17	  scanf("%lf", &z);
    18	  
    19	  sum1 = x + y;
    20	  sum1 += z;      /* sum1 = (x + y) + z */
    21	  sum2 = y + z;
    22	  sum2 += x;      /* sum2 = x + (y + z) */
    23	
    24	  if (sum1 == sum2)
    (gdb) b 24
    Breakpoint 1 at 0x126b: file threeDoubles.c, line 24.
    (gdb) r
    Starting program: /home/bob/NoStarch/x-86/progs/working/chapter_19/Your_Turn/threeDoubles_C/threeDoubles 
    Enter a number: 1.1
    Enter a number: 1.2
    Enter a number: 1.3

    Breakpoint 1, main () at threeDoubles.c:24
    24	  if (sum1 == sum2)
    (gdb) p sum1
    $1 = 3.5999999999999996
    (gdb) p sum2
    $2 = 3.6000000000000001
    (gdb) c
    Continuing.
    3.600000 is not the same as 3.600000
    [Inferior 1 (process 6631) exited normally]
    (gdb) 
    ```

