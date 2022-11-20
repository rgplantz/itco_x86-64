---
layout: default
title: x86-64 Corrections
---
{% include mathjax.html %}
# x86-64 Corrections

*Updated 19 November 2022*

- Page 23: Table 2-6, should be:
    
    |   Address   | Content |   Address    | Content |
    | ----------- | ------- | ------------ | ------- |
    | `0x4004a1:` | `0x48`  | `0x4004a8:`  | `0x57`  |
    | `0x4004a2:` | `0x65`  | `0x4004a9:`  | `0x6f`  |
    | `0x4004a3:` | `0x6c`  | `0x4004aa:`  | `0x72`  |
    | `0x4004a4:` | `0x6c`  | `0x4004ab:`  | `0x6c`  |
    | `0x4004a5:` | `0x6f`  | `0x4004ac:`  | `0x64`  |
    | `0x4004a6:` | `0x2c`  | `0x4004ad:`  | `0x21`  |
    | `0x4004a7:` | `0x20`  | `0x4004ae:`  | `0x00`  |
- Page 33: In the second code block, `$2 = "123abc\000\177\000>` should be `$2 = "123abc\000\177\000"`. Note that you may see different numbers after the first `\000`; these are "garbage" values after the text string that were left in memory. You'll learn more about this when we get into assembly language starting in Chapter 10. (Thanks to 陈端阳)
- Page 33: In the third code block, on the first line, the `#` in `%#x` is *not* an error. It causes `printf` to use an "alternate form" for the display. In our case, it places `0x` at the beginning of the hexadecimal display. (Thanks to 陈端阳)
- Page 40: The algorithm at the bottom of the page should be (The _ character indicates subscript in this algorithm.) (Thanks to Erlis Ruli):
    ```
    Let carry_i = 0
    Repeat for each i = 0,..., (N-1)            // starting in ones place
        sum_i = x_i + y_i + carry_i % 10        // remainder
        carry_(i+1) = x_i + y_i + carry_i / 10  // integer division
    ```
- Page 41: Second paragraph, "...ultimate carry is..." should be "...ultimate carry, `carry_N`, is..." (Thanks to Erlis Ruli):

- Page 42: In the subtraction algorithm at top of the page, the "Let" on the last line should be aligned with the "While" four lines above. (The _ character indicates subscript in this algorithm.)
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
- Page 46: The list items 3 and 4 should be numbered 1 and 2, respectively. This is a separate arithmetic operation from the two steps (1 and 2) just above.
- Page 47: In the equation at the bottom, there should not be a space between '+' and '('.
- Page 50: At the bottom of the page, "In the previous example" should be "In this example."
- Page 69: In the first paragraph of the **Canonical Product or Product of Maxterms** section, "design that specifies when carry is `0`" should be "design that specifies when the complement of carry is `0`."
- Page 71: Delete the last row, the one with ..., from Table 4-8.
- Page 75: Just above the last equation, "manipulations to other two groupings" should be "manipulations to the other two groupings."
- Page 81: In Figures 4-15, the horizontal axis should be labeled "`xy`" not "`yz`."
- Page 82: In Figure 4-12 and 4-13, the horizontal axis should be labeled "`xy`" not "`yz`."
- Page 87: The last paragraph in Your Turn ("Design a logic function...") should be labeled as exercise 7.
- Page 90: "Power source that provides..." should be "Power sources that provide..."
- Page 93: The third line of the second equation "ohms" should be "amps." (Thanks to 陈端阳)
- Page 95: In the first line below the first equation "voltage difference across the resistor" should be "voltage difference across the capacitor."
- Page 97: The first equation should be (Thanks to 陈端阳):
  $$
  \begin{aligned}
    V_{BC} &= 5.0\ (1-e^{\frac{-6\times 10^{-3}}{10^{-3}}})\\
           &= 5.0\ (1-e^{-6})\\
           &= 5.0\ \times 0.9975 \\
           &= 4.9876 \textrm{ volts}
  \end{aligned}
  $$
- Page 100: In the last full paragraph on the page "When the button is not pushed..." should be "When the buttons are not pushed...", and "When the button is pushed..." should be "When the buttons are pushed..."
- Page 104: The caption of Figure 5-13 should be "P-channel MOSFET switch equivalent circuit: (a) switch open, (b) switch closed"
- Page 107: In the description of **NAND**, "We’ll use $$\neg(x \wedge x)$$ to designate the NAND operation." should be: "We’ll use $$\neg(x \wedge y)...$$ (Thanks to 陈端阳)
- Page 109: In the first paragraph "$$\neg ((\neg x) \vee (\neg y))$$" should be "$$\neg (\neg x \wedge \neg y)$$"
- Page 117: The last equation, line 4 should be (Thanks to 陈端阳): $$\neg(x_i \veebar y_i)$$
- Page 118: The first equation should be (Thanks to 陈端阳):
  $$
  \begin{aligned}
    Sum_i(Carry_i,x_i,y_i) &= \neg Carry_i \wedge (x_i \veebar y_i)\vee Carry_i \wedge \neg(x_i\veebar y_i)\\
                           &=Carry_i \veebar(x_i \veebar y_i)
  \end{aligned}
  $$
- Page 118: In the second equation, $$Carry_{i+1}$$ should be $$Carry_{i+1}(Carry_i,x_i,y_i)$$.
- Page 120: In Figure 6-7, `s = s + y` should be `s = x + y`.
- Page 127: In the first paragraph, both instances of $$s_{0}s_{1}$$ should be $$s_{1}s_{0}$$, and "...would be connected one of..." should be "...would be connected to one of...
- Page 137: First sentence, "...for an SR." should be "...for an SR latch."
- Page 137: In the description of S = `0`, R = `0`, "...upper NOT gate..." should be "...upper NOR gate..."
- Page 148: First line, "...D flip-flop..." should be "...D latch..."
- Page 150: In the middle of the page, "The leads us..." should be "This leads us..."
- Page 187: In the third paragraph, "...range -32,767 to +32,767..." should be "...range -32,768 to +32,767...", and "...at least 0 to 65,525..." should be "...at least 0 to 65,535...". (Thanks to 陈端阳)
- Page 256: The comments in the first code block should read (Thanks to 陈端阳):
    ```
            jne     skip    # do not jump if equal
            jmp     FarAway # jump if equal
    skip:   next instruction
    ```
- Page 282: On the second line on the page, "`if-else`" should be "`else-if`".
- Page 282: Near the bottom of the "`else-if`" general form, "`else` *`(expression_n)`*" should be "`else`".
- Page 293: Second line in Listing 14-4 should read, `Adds two global integers.`
- Page 345: In Listing 16-9 (Thanks to 陈端阳):
    ```
      *intPtr = *intPtr  4;
    ```
    should be
    ```
      *intPtr = *intPtr<<4;
    ```
- Page 375: In the third paragraph, "...with the `cdge` instruction..." should be "...with the `cdqe` instruction..." (Thanks to 陈端阳)
