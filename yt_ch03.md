---
layout: default
title: Chap 3
parent: Solutions
nav_order: 10
---

# Chapter 3 Solutions

## Page aa
1. Four bits are required to store a single decimal digit.
   Many codes could be used. This one uses the binary number system.


    |digit| code |digit| code |
    |-----|------|-----|------|
    |  0  |`0000`|  5  |`0101`|
    |  1  |`0001`|  6  |`0110`|
    |  2  |`0010`|  7  |`0111`|
    |  3  |`0011`|  8  |`1000`|
    |  4  |`0100`|  9  |`1001`|

2. Binary addition
```
    Let carry = 0
    Repeat for each i = 0,...,(n - 1)  // starting in ones place
        sumi = (xi + yi) % 2           // remainder
        carry = (xi + yi) / 2         // integer division
```
3. Hexadecimal addition
```
    Let carry = 0
    Repeat for each i = 0,...,(n - 1)  // starting in ones place
        sumi = (xi + yi) % 16           // remainder
        carry = (xi + yi) / 16         // integer division
```
4. Binary subtraction
```
    Let borrow = 0
    Repeat for i = 0,··· ,(N − 1)
    If yi ≤ xi 
        Let differencei = xi − yi
    Else
        Let j = i + 1
        While (xi = 0) and (j < N)
            Add 1 to j
        If j = N
            Let borrow = 1
            Subtract 1 from j
            Add 2 to xi
        While j > i
            Subtract 1 from xi
            Subtract 1 from j
            Add 2 to xi
        Let differencei = xi − yi
```
5. Hexadecimal subtracton
```
    Let borrow = 0
    Repeat for i = 0,··· ,(N − 1)
    If yi ≤ xi 
        Let differencei = xi − yi
    Else
        Let j = i + 1
        While (xi = 0) and (j < N)
            Add 1 to j
        If j = N
            Let borrow = 1
            Subtract 1 from j
            Add 2 to xi
        While j > i
            Subtract 1 from xi
            Subtract 1 from j
            Add 2 to xi
        Let differencei = xi − yi
```
