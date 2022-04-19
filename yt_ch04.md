---
layout: default
title: Chapter 4
---

## Chapter 4

### Page 66
1.  Associativity of AND and OR is shown in Tables 4-3 and 4-4 in the book.
2.  AND and OR identity values

    |  x  | x &and; 1 |
    |-----|-----------|
    | `0` |    `0`    |
    | `1` |    `1`    |

    |  x  | x &or; 0  |
    |-----|-----------|
    | `0` |    `0`    |
    | `1` |    `1`    |

3. AND and OR commutativity

    |  x  |  y  | x&and;y | y&and;x |
    |-----|-----|---------|---------|
    | `0` | `0` |   `0`   |   `0`   |
    | `0` | `1` |   `0`   |   `0`   |
    } `1` | `0` |   `0`   |   `0`   |
    | `1` | `1` |   `1`   |   `1`   |

    |  x  |  y  | x&or;y  | y&or;x  |
    |-----|-----|---------|---------|
    | `0` | `0` |   `0`   |   `0`   |
    | `0` | `1` |   `1`   |   `1`   |
    } `1` | `0` |   `1`   |   `1`   |
    | `1` | `1` |   `1`   |   `1`   |

4. AND distributive over OR

    |  x  |  y  |  z  | (y&or;z) | (x&and;y) | (x&and;z) | (x&and;(y&or;z) | (x&and;y)&or;(x&and;z) |
    |-----|-----|-----|----------|-----------|-----------|-----------------|------------------------|
    | `0` | `0` | `0` |   `0`    |    `0`    |    `0`    |     `0`         |           `0`          |    
    | `0` | `0` | `1` |   `1`    |    `0`    |    `0`    |     `0`         |           `0`          |
    | `0` | `1` | `0` |   `1`    |    `0`    |    `0`    |     `0`         |           `0`          |
    | `0` | `1` | `1` |   `1`    |    `0`    |    `0`    |     `0`         |           `0`          |
    | `1` | `0` | `0` |   `0`    |    `0`    |    `0`    |     `0`         |           `0`          |
    | `1` | `0` | `1` |   `1`    |    `0`    |    `1`    |     `1`         |           `1`          |
    | `1` | `1` | `0` |   `1`    |    `1`    |    `0`    |     `1`         |           `1`          |
    | `1` | `1` | `1` |   `1`    |    `1`    |    `1`    |     `1`         |           `1`          |


5. AND annulment

    |  x  | x &and; 0 |
    |-----|-----------|
    | `0` |    `0`    |
    | `1` |    `0`    |
  
6. Involution of NOT
   
    |  x  | (&not;x) | &not;(&not;x) |
    |-----|----------|---------------|
    | `0` |    `1`   |      `0`      |
    | `1` |    `0`   |      `1`      |

7. OR distributive over AND is shown in Table 4-5 in book.

8. OR annulment value

    |  x  | x &or; 1  |
    |-----|-----------|
    | `0` |    `1`    |
    | `1` |    `1`    |

9.  AND and OR complements

    |  x  | &not;x | x &and; &not;x |
    |-----|--------|----------------|
    | `0` |  `1`   |      `0`       |
    | `1` |  `0`   |      `0`       |

    |  x  | &not;x | x &or; &not;x |
    |-----|--------|----------------|
    | `0` |  `1`   |      `1`       |
    | `1` |  `0`   |      `1`       |

10. AND and OR idempotency

    |  x  | x&and;x |
    |-----|---------|
    | `0` |   `0`   |
    | `1` |   `1`   |

    |  x  | x&or;x  |
    |-----|---------|
    | `0` |   `0`   |
    | `1` |   `1`   |

11. De Morgan's law

    |  x  |  y  |  (x&and;y)  | &not;(x&and;y) | &not;x | &not;y | &not;x &or; &not;y |
    |-----|-----|-------------|----------------|--------|--------|--------------------|
    | `0` | `0` |     `0`     |      `1`       |   `1`  |   `1`  |       `1`          |    
    | `0` | `1` |     `0`     |      `1`       |   `1`  |   `0`  |       `1`          |
    | `1` | `0` |     `0`     |      `1`       |   `0`  |   `1`  |       `1`          |
    | `1` | `1` |     `1`     |      `0`       |   `0`  |   `0`  |       `0`          |

    |  x  |  y  |  (x&or;y)  | &not;(x&or;y) | &not;x | &not;y | &not;x &and; &not;y |
    |-----|-----|------------|---------------|--------|--------|---------------------|
    | `0` | `0` |     `0`    |      `1`      |   `1`  |   `1`  |        `1`          |    
    | `0` | `1` |     `1`    |      `0`      |   `1`  |   `0`  |        `0`          |
    | `1` | `0` |     `1`    |      `0`      |   `0`  |   `1`  |        `0`          |
    | `1` | `1` |     `1`    |      `0`      |   `0`  |   `0`  |        `0`          |

### Page 87
1. Let a 4-bit integer be *wxyz* where each literal represents one bit. The even 4-bit integers are given by the function:

   F(w,x,y,z) = &not;w &and; &not;x &and; &not;y &and; &not;z
      &or; &not;w &and; &not;x &and; y &and; &not;z
      &or; &not;w &and; x &and; &not; y &and; &not;z
      &or; &not;w &and; x &and; y &and; &not;z
      &or; w &and; &not;x &and; &not;y &and; &not;z
      &or; w &and; &not;x &and; y &and; &not;z
      &or; w &and; x &and; &not;y &and; &not;z
      &or; w &and; x &and; y &and; &not;z
      
   Using the distributive property repeatedly we get:

   F(w,x,y,z) = &not;z &and; (&not;w &and; &not;x &and; &not;y
      &or; &not;w &and; &not;x &and; y &or; &not;w &and; x &and; &not; y
      &or; &not;w &and; x &and; y &or; w &and; &not;x &and; &not;y
      &or; w &and; &not;x &and; y &or; w &and; x &and; &not;y
      &or; w &and; x &and; y)

    = &not;z &and; (&not;w &and; (&not;x &and; &not;y &or; &not;x &and; y &or; x &and; &not; y &or; x &and; y)
     &or; (&not;w &and; (&not;x &and; &not;y &or; &not;x &and; y &or; x &and; &not; y &or; x &and; y)

    = &not;z &and; (&not;w &or; w) &and; (&not;x &and; &not;y &or; &not;x &and; y &or; x &and; &not; y &or; x &and; y)
    
    = &not;z &and; (&not;w &or; w) &and; (&not;x &and; (&not;y &or; y) &or; x &and; (&not; y &or; y)
    
    = &not;z &and; (&not;w &or; w) &and; (&not;x &or; x) &and; (&not; y &or; y)

   And from the complement property we arrive at a minimal sum of products:

   F(w,x,y,z) = &not;z

   a simple NOT gate with the least significant bit as input.
2. 
3. 
4. ![](./assets/images/ch_04/p87_4.svg)
5. ![](./assets/images/ch_04/p87_5.svg)
6. ![](./assets/images/ch_04/p87_6.svg)
7. 