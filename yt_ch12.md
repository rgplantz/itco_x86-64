---
layout: default
title: Chapter 12
---

## Chapter 12

### Page 258
1.  
    ```
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
    Let's look at the code for `mov     r11d, r10d`. We can tell from the manual and several other `mov` instructions that the opcode is `89`. It's prefaced with a REX byte, `01000101`. The W bit is `0`, showing that the data being moved is not 64 bits but the default 32 bits. The `R` and `B` bits in the REX byte are both `1` which are used as the high-order bit to specify the registers. The ModR/B byte is `11010011`. Figure 2-5 in the xxx version of the Intel manual shows that the first two bits, `11`, specify a register-to-register move. The next three bits combine with the `R` bit in the REX byte to give `1010`, which Table 12-2 in our book shows is `r10`. The last three bits combine with the `B` bit in the REX byte to give `1011`, which specifies `r11`.
2.  
    ```
    GAS LISTING regToMemory.s 			page 1


       1              	# regToMemory.s
       2              	# Some instructions to illustrate machine code.
       3              	        .intel_syntax noprefix
       4              	        .text
       5              	        .globl  main
       6              	        .type   main, @function
       7              	main:
       8 0000 55       	        push    rbp         # save caller's frame pointer
       9 0001 4889E5   	        mov     rbp, rsp    # establish our frame pointer
      10 0004 4883EC30 	        sub     rsp, 48     # local variables
      11              	        
      12 0008 48C7C105 	        mov     rcx, 5              # for indexing
      12      000000
      13 000f 8B4500   	        mov     eax, [rbp]          # indirect
      14 0012 8945D0   	        mov     -48[rbp], eax       # indirect + offset  
      15 0015 89440DD0 	        mov     -48[rbp+rcx], eax   # indirect + offset and index 
      16 0019 89448DD0 	        mov     -48[rbp+4*rcx], eax #      and scaled index 
      17              	       
      18 001d B8000000 	        mov     eax, 0      # return 0 to os
      18      00
      19 0022 4889EC   	        mov     rsp, rbp    # restore stack pointer
      20 0025 5D       	        pop     rbp         #   and frame pointer
      21 0026 C3       	        ret                 # back to caller
    ```
    Look at the three instructions where we reversed the order of the source and destination thus moving from a register to memory. Comparing the machine code with the respective instructions in Listing 12-3, we see that the only thing that has chaned is the opcode has changed from `8B` to `89`.

3.  
    ```
    GAS LISTING constToMemory.s 			page 1


       1              	# constToMemory.s
       2              	# Some instructions to illustrate machine code.
       3              	        .intel_syntax noprefix
       4              	        .text
       5              	        .globl  main
       6              	        .type   main, @function
       7              	main:
       8 0000 55       	        push    rbp         # save caller's frame pointer
       9 0001 4889E5   	        mov     rbp, rsp    # establish our frame pointer
      10 0004 4883EC30 	        sub     rsp, 48     # local variables
      11              	        
      12 0008 48C7C105 	        mov     rcx, 5              # for indexing
      12      000000
      13 000f 8B4500   	        mov     eax, [rbp]          # indirect
      14 0012 C745D034 	        mov     dword ptr -48[rbp], 0x12000034       # indirect + offset  
      14      000012
      15 0019 C7440D30 	        mov     dword ptr -48[rbp+rcx], 0x56000078   # indirect + offset and index 
      15      78000056 
      16 0021 C7448DD0 	        mov     dword ptr -48[rbp+4*rcx], 0x91000023 #      and scaled index 
      16      23000091 
      17              	       
      18 0029 B8000000 	        mov     eax, 0      # return 0 to os
      18      00
      19 002e 4889EC   	        mov     rsp, rbp    # restore stack pointer
      20 0031 5D       	        pop     rbp         #   and frame pointer
      21 0032 C3       	        ret                 # back to caller
    ``` 
    Let's look at the `mov     dword ptr -48[rbp+4*rcx], 0x91000023` instruction. The opcode is `0xc7`. That's followed by a ModR/M byte, an SIB byte, an offset byte, and four bytes for the constant.
    
    The `0x44` value for the ModR/B byte means that it is followed by an SIB byte with a one-byte offset. The SIB byte, `10 001 101`, specifies a scale factor of 4, `rcx` is the index register, and `rbp` is the base register. The offset is stored as a one-byte, two's complement value: `0xd0` = -48<sub>10</sub>. Notice that the constant, `0x91000023`, is stored in little endian order, `0x23000091`.
    