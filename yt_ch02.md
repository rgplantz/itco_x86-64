---
layout: default
title: Chap 2
parent: Solutions
nav_order: 10
---

# Chapter 2 Solutions

## Page aa
1. Binary to hexadecimal

    - `0100 0101 0110 0111` = `4567`
    - `1000 1001 1010 1011` = `89ab`
    - `1111 1110 1101 1100` = `fedc`
    - `0000 0010 0101 0010` = `0252`

2. Hexadecimal to binary

    - `83af` = `1000 0011 1010 1111`
    - `9001` = `1001 0000 0000 0001`
    - `aaaa` = `1010 1010 1010 1010`
    - `5555` = `0101 0101 0101 0101`

3. Number of bits
    - `ffffffff`, 32 bits
    - `7fff58b7def0`, 48 bit
    - `1111` in binary is 4 bits
    - `1111` in hexadecimal is 16 bits


4. Number of hexadecimal digits
    - 8 bits, 2 hex digits
    - 32 bits, 8 hex digits
    - 64 bits, 16 hex digits
    - 10 bits, 3 hex digits
    - 20 bits, 5 hex digits
    - 7 bits, 2 hex digits

## Page bb
1. r = 10, n = 8, d<sub>7</sub> = 2, d<sub>6</sub> = 9, d<sub>5</sub> = 4, d<sub>4</sub> = 5, d<sub>3</sub> = 8, d<sub>2</sub> = 2, d<sub>1</sub> = 5, d<sub>0</sub> = 4 and r = 16, n = 8, d<sub>7</sub> = 2, d<sub>6</sub> = 9, d<sub>5</sub> = 4, d<sub>4</sub> = 5, d<sub>3</sub> = 8, d<sub>2</sub> = 2, d<sub>1</sub> = 5, d<sub>0</sub> = 4

2. Binary to decimal
    - `1010 1010` = 170
    - `0101 0101` = 85
    - `1111 0000` = 240
    - `0000 1111` = 15
    - `1000 0000` = 128
    - `0110 0011` = 99
    - `0111 1011` = 123
    - `1111 1111` = 255

3. Binary to decimal
    - `1010 1011 1100 1101` = 43981
    - `0001 0011 0011 0100` = 4916
    - `1111 1110 1101 1100` = 65244
    - `0000 0111 1101 1111` = 2015
    - `1000 0000 0000 0000` = 32768
    - `0000 0100 0000 0000` = 1024
    - `0111 1011 1010 1010` = 31658
    - `0011 0000 0011 1001` = 12345

4. Hexadecimal to decimal
    - `a000` = 40960
    - `ffff` = 65535
    - `0400` = 1024
    - `1111` = 4369
    - `8888` = 34952
    - `0190` = 400
    - `abcd` = 43981
    - `5555` = 21845

## Page cc
1. Unsigned decimal to hexadecimal
    - 100 = `64`
    - 123 = `7b`
    - 10 = `0a`
    - 88 = `58`
    - 255 = `ff`
    - 16 = `10`
    - 32 = `20`
    - 128 = `80`

2. Unsignged decimal to hexadecimal
    - 1024 = `0400`
    - 1000 = `03e8`
    - 32768 = `8000`
    - 32767 = `7fff`
    - 256 = `0100`
    - 65535 = `ffff`
    - 4660 = `1234`
    - 43981 = `abcd`

## Page dd
1. Uppercase A - F
   - A: `0x41`
   - B: `0x42`
   - C: `0x43`
   - D: `0x44`
   - E: `0x45`
   - F: `0x46`

2. Lowercase

    |char| code |char| code |char| code |char| code |char| code |
    |----|------|----|------|----|------|----|------|----|------|
    | a  |`0x61`| g  |`0x67`| m  |`0x6d`| s  |`0x73`| y  |`0x79`| 
    | b  |`0x62`| h  |`0x68`| n  |`0x6e`| t  |`0x74`| z  |`0x7a`|
    | c  |`0x63`| i  |`0x69`| o  |`0x6f`| u  |`0x75`|
    | d  |`0x64`| j  |`0x6a`| p  |`0x70`| v  |`0x76`|
    | e  |`0x65`| k  |`0x6b`| q  |`0x71`| w  |`0x77`|
    | f  |`0x66`| l  |`0x6c`| r  |`0x72`| x  |`0x78`|

3. Uppercase

    |char| code |char| code |char| code |char| code |char| code |
    |----|------|----|------|----|------|----|------|----|------|
    | A  |`0x41`| G  |`0x47`| M  |`0x4d`| S  |`0x53`| Y  |`0x59`| 
    | B  |`0x42`| H  |`0x48`| N  |`0x4e`| T  |`0x54`| Z  |`0x5a`|
    | C  |`0x43`| I  |`0x49`| O  |`0x4f`| U  |`0x55`|
    | D  |`0x44`| J  |`0x4a`| P  |`0x50`| V  |`0x56`|
    | E  |`0x45`| K  |`0x4b`| Q  |`0x51`| W  |`0x57`|
    | F  |`0x46`| L  |`0x4c`| R  |`0x52`| X  |`0x58`|

4. Punctuation

    |char| code |char| code |char| code |char| code |char| code |
    |----|------|----|------|----|------|----|------|----|------|
    |spc |`0x20`| '  |`0x27`| .  |`0x2e`| ?  |`0x3f`| ` |`0x60`|
    | !  |`0x21`| (  |`0x28`| /  |`0x2f`| @  |`0x40`| {  |`0x7b`|
    | "  |`0x22`| )  |`0x29`| :  |`0x3a`| [  |`0x5b`| }  |`0x7c`|
    | #  |`0x23`| *  |`0x2a`| ;  |`0x3b`| \\  |`0x5c`| \| |`0x7d`|
    | $  |`0x24`| +  |`0x2b`| <  |`0x3c`| ]  |`0x5d`| ~  |`0x7e`|
    | %  |`0x25`| ,  |`0x2c`| =  |`0x3d`| ^  |`0x5e`|
    | &  |`0x26`| -  |`0x2d`| >  |`0x3e`| _  |`0x5f`|

## Page ee
1. 

    ```c
    /* dec2Hex.c
    * Converts from decimal to hexadecimal
     */

    #include <stdio.h>

    int main(void)
    {
    unsigned int value;

    printf("Decimal: ");
    scanf("%u", &value);
    printf("%u = 0x%02x\n", value, value);

    return 0;
    }
    ```

2. 

    ```c
    /* hex2Dec.c
    * Converts from hexadecimal to decimal
    */

    #include <stdio.h>

    int main(void)
    {
    unsigned int value;

    printf("Hexadecimal: ");
    scanf("%x", &value);
    printf("0x%02x = %u\n", value, value);

    return 0;
    }

    ```

3. The integer is -1, and the string is `0xffffffff`.
