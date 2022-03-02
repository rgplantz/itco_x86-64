---
layout: default
title: x86-64 Errata
---
# x86-64 Errata

* 22 February 2022: Table 2-6, page 23, should be:

    Table 2-6: "Hello, World!" stored in memory
    
    |   Address   | Content |   Address    | Content |
    | ----------- | ------- | ------------ | ------- |
    | `0x4004a1:` | `0x48`  | `0x4004a8:`  | `0x57`  |
    | `0x4004a2:` | `0x65`  | `0x4004a9:`  | `0x6f`  |
    | `0x4004a3:` | `0x6c`  | `0x4004aa:`  | `0x72`  |
    | `0x4004a4:` | `0x6c`  | `0x4004ab:`  | `0x6c`  |
    | `0x4004a5:` | `0x6f`  | `0x4004ac:`  | `0x64`  |
    | `0x4004a6:` | `0x2c`  | `0x4004ad:`  | `0x21`  |
    | `0x4004a7:` | `0x20`  | `0x4004ae:`  | `0x00`  |

* 1 March 2022: Subtraction algorithm at top of page 42. The "Let" on the last line should be aligned with the "While" four lines above. (The _ character indicates subscript in this algorithm.)
    ```
    Let borrow = 0
    Repeat for each i = 0,..., (N-1)
        If y_i <= x_i
            Let difference_i = x_i - y_i
        Else
            Let j = i + 1
            While (x_j = 0) and (j < N)
                Add 1 to j
            If j = N
                Let borrow = 1
                Subtract 1 from j
                Add 10 to x_j
            While j > i
                Subtract 1 from x_j
                Subtract 1 from j
                Add 10 to x_j
            Let difference_i = x_i - y_i
    ```
* 3 March 2022: Equation at the bottom of page 47. There should not be a space between '+' and '('.
* 3 March 2022: At the end of the second full paragraph on page 50, "In the previous example" should be "In this example."
  