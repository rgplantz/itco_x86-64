---
layout: default
title: x86-64 Errata
---
{% include lib/mathjax.html %}
# x86-64 Errata

- 21 March 2022: In the second code block on page 33, `$2 = "123abc\000\177\000>` should be `$2 = "123abc\000\177\000"`. Note that you may see different numbers after the first `\000`; these are "garbage" values after the text string that were left in memory. You'll learn more about this when we get into assembly language starting in Chapter 10. (Thanks to 陈端阳)
- 21 March 2022: In the third code block on page 33, on the first line, the `#` in `%#x` is *not* an error. It causes `printf` to use an "alternate form" for the display. In our case, it places "0x" at the beginning of the hexadecimal display.
- 21 March 2022: On page 93, the third line of the second equation reads $$2.0\times 10^{-3}$$ ohms, but it should should be $$2.0\times 10^{-3}$$ amps.
- 21 March 2022: On page 97 the first equation should be:
  $$
  \begin{aligned}
    V_{BC} &= 5.0\ (1-e^{\frac{-6\times 10^{-3}}{10^{-3}}})\\
           &= 5.0\ (1-e^{-6})\\
           &= 5.0\ \times 0.9975 \\
           &= 4.9876 \textrm{ volts}
  \end{aligned}
  $$
- 21 March 2022: On page 107 in the description of **NAND**, "We’ll use $$\neg(x \land x)$$ to designate the NAND operation." should be "We’ll use $$\neg(x \land y)...$$"
- 21 March 2022: On page 117 the last equation, line 4 should be $$\neg(x_i \veebar y_i)$$
- 21 March 2022: At the top of page 118, the first equation should be
  $$
  \begin{aligned}
    Sum_i(Carry_i,x_i,y_i) &= \neg Carry_i \land (x_i \veebar y_i)\vee Carry_i \land \neg(x_i\veebar y_i)\\
                           &=Carry_i \veebar(x_i \veebar y_i)
  \end{aligned}
  $$
- 3 March 2022: At the end of the second full paragraph on page 50, "In the previous example" should be "In this example."
- 3 March 2022: Equation at the bottom of page 47. There should not be a space between '+' and '('.
- 1 March 2022: Subtraction algorithm at top of page 42. The "Let" on the last line should be aligned with the "While" four lines above. (The _ character indicates subscript in this algorithm.)
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
- 22 February 2022: Table 2-6, page 23, should be:

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

  