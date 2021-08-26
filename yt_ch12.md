---
layout: default
title: Chapter 12
---

## Chapter 12

### Page 241
1.  
    ```asm
    GAS LISTING register_change.s 			page 1


       1              	# register_change.s
       2              	# Some instructions to illustrate machine code.
       3              	        .intel_syntax noprefix
       4              	        .text
       5              	        .globl  main
       6              	        .type   main, @function
       7              	main:
       8 0000 55       	        push    rbp         # save caller's frame pointer
       9 0001 4889E5   	        mov     rbp, rsp    # establish our frame pointer
      10              	        
      11 0004 89C1     	        mov     ecx, eax    # 32 bits, low reg codes
      12 0006 89DA     	        mov     edx, ebx    # highest reg codes
      13 0008 6689D3   	        mov     bx, dx      # 16 bits
      14 000b 88D3     	        mov     bl, dl      # 8 bits
      15 000d 4589D3   	        mov     r11d, r10d  # 32 bits, 64-bit register
      16 0010 4889DA   	        mov     rdx, rbx    # 64 bits
      17              	
      18 0013 B8000000 	        mov     eax, 0      # return 0 to os
      18      00
      19 0018 4889EC   	        mov     rsp, rbp    # restore stack pointer
      20 001b 5D       	        pop     rbp         #   and frame pointer
      21 001c C3       	        ret                 # back to caller
    ```
    Let's look at the code for `mov     r11d, r10d`. It's prefaced with a REX byte, `01000101`. The W bit is `0`, showing that this is not a 64-bit instruction, so the default 32-bit is used. 
