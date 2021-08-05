---
layout: default
title: Chapter 10
---

## Chapter 10

### Page aa
1. The program doesn't change `rsp` after the first instruction pushes `rbp`, so this instruction doesn't change the values in any registers. TUI only highlights changes.
   
   Changing the exit value to 123 gave me `Inferior 1 (process 4891) exited with code 0173]` when `gdb` ended execution of the program. A number beginning with `0` in `gdb` means that it's in octal: `173`<sub>8</sub> = 123<sub>10</sub>

2.  