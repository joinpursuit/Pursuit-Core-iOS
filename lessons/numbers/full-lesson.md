# Standards:
* Master conditionals in all their forms and their relationship to boolean logic.
* Master foundational mathematical concepts

# Objectives
Students will be able to:
* Differentiate between number types (e.g Int vs Float)
* Solve problems using integer operations
* Apply newly learned information about numbers to conditionals

# Resources
Swift Programming: The Big Nerd Ranch Guide, Chapter 4, Numbers

Apple's [Swift Language Reference, The Basics](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309) Seek to **Integers**

# Assessment Materials
## Midday Check-in and solutions

## Warm up
Math exercises:
[Order of operations](https://www.mathsisfun.com/operation-order-pemdas.html)

Simplify the following expressions:

1) 4 + 3 * 5

2) 3 / 3 * 2 + 5

3) 2 ^ 6 - 5

4) 5 + 4 / 2

5) 9 - 3 * 4 - 2

6) 4 * (-4) - 2

7) 4 + 5 ^ 3 * 6 / 3


## Integers
Integer is a term borrowed (taken) from mathematics to describe a number that's not a fraction 
in the range from -∞ to +∞, including zero. Since computers don't really do infinity we change the definition, substituting minimum and maximum numbers for the infinities. The basic type for integers in Swift is ```Int```. Before we explore the many related Int types it's important to note that 
for almost all cases it's considered best to use ```Int```. 

### Integer size

```swift
let minValue = UInt8.min  // minValue is equal to 0, and is of type UInt8
let maxValue = UInt8.max  // maxValue is equal to 255, and is of type UInt8
```

**Exercise**

* Take the code block above and test different mins and maxes. Use Int, Int8, Int16, Int32, and Int64

### Signedness

A "signed" integer can be positive, negative or zero
An "unsigned" integer can only represent positive number or zero

Swift offers unsigned versions of all the interger types. The main advantage of unsigned integers is that it doubles the size of the positive range of the type. This used to be more of an issue when memory was limited and squeezing every bit was a valuable optimization. Now, there are only some use cases that call for it. Similar to the specific Int sizes, controlling the signedness of integers has applications in networking where systems need to agree on the exact format of the data they're communicating.


**Question**: Think of applications that require using a very large number.
```
ids on a popular service like Facebook and Twitter.
Scientific and mathematical applications that require exact precision.
```
**Exercise**

* Take the code block above and test different mins and maxes. Use UInt, UInt8, UInt16, UInt32, and UInt64
* Compare them to their corresponding signed type, e.g. UInt8 to Int8.


## Creating instances of ```Int``` 

```swift
let numBonesInHumanBody = 206 // Int by default
let numLettersInEnglishAlphabet: Int8 = 26  // type annotation lets us control
```

## Integer operations

|Symbol| Operation          | Example | Result | 
|------|--------------------|---------|--------|
| +    | Addition           | 5 + 8   |  13    |
| -    | Subtraction        | 5 - 8   |  -3    |
| *    | Multiplication     | 5 * 8   | 40     |
| /    | Division           | 5 / 8   | 0      |
| %    | Modulo             | 5 % 8   | 5      |

### Integer division

When dividing integers the expression always evaluates to the whole part of the calculation. 
This can be thought of as throwing away any numbers "after the decimal point".

```swift
let nineDivThree = 9 / 3 //  3 
let halfOfFive = 5 / 2 //  2 
```

There is a partner operator to pick up that remainder named the modulo (sometimes called modulus).
```swift
let nineDivThree = 9 % 3 //  0 
let halfOfFive = 5 % 2 //  1 
```

**Exercise**: 
* Try various division examples.
* Try corresponding modulo examples.
* Recreate this exact message using calculations that use /, % and 
string interpolation (that's where we 
insert \\(_expression_) in the middle of a string to display a value.):
```
12 / 5 = 2, remainder 2.
```

### Operator shorthand

Given:
```swift
var i = 10
```

|Symbol| Operation              | Example  | Result | 
|------|------------------------|----------|--------|
| +=    | Add and assign        | i += 3   |  13    |
| -=    | Subtract and assign   | i -= 5   |   5    |
| *=    | Multiply and assign   | i *= 3   |  30    |
| /=    | Divide and assign     | i /= 4   |   2    |
| %=    | Mod and assign        | i %= 3   |   5    |

```swift
var i = 0 // 0
i += 1 // 1
```

**Note**: You might see mention of the ++ and -- operators. They've been deprecated in Swift 3. 
Since ```i += 1``` offers the same functionality as ```i++``` it makes sense.

### Overflow operators

You may see that Swift supports overflow operators. They're not used in everyday coding but
the reason they exist is worth looking at quickly. Overflow refers to the result of trying
to perform an operation that would result in a value that goes over the maximum, or under the 
minimum value of the data type.

```swift
var x: Int8 = 100
x += 30
```

That crashes, which is actually what we want it to do. This alerts us to the fact that 
we have overflow and we're more likely to fix it. There are operators that will make the value
wrap around and our program won't crash but most likely the value we get is totally not what we expect.

**Takeaway**: Sometimes it's good to crash.

### Conversion between integer types

### Storage of Integers

https://www.mathsisfun.com/binary-number-system.html

### Signed Integer Storage

https://en.wikipedia.org/wiki/Two%27s_complement

## Floating-point numbers
Floating-point numbers are used to represent the set of mathematical "real" numbers. 
Floating-point refers to the fact that the decimal point can be placed anywhere whithin the 
number. The computer stores floats in two parts: the mantissa and exponent. It could be an interesting
math discussion but for our purposes we just need to know:

* floating point numbers are very close approximations
* for a given data type they have a fixed precision. This limitation/power is exposed when you 
enter a very large or very small number

Swift has two floating-point types ```Float``` and ```Double```. Floats are stored in 32 bits
and Doubles in 64. Hence double. Not double the size but double the precision. Double the fun?
Not really.

```swift
let heightInMeters = 1.89 // Swift defaults to Double
let weightInKilos: Double = 111.34
let speedInKMP: Float = 66.7
```

### Storage of Floating Point numbers 

http://programmers.stackexchange.com/questions/215065/can-anyone-explain-representation-of-float-in-memory

### Beware of comparisons

Because floating-points are always approximations exact comparisons sometimes don't give expected results.

```swift
let d1 = 1.1
let d2 = 1.1

if d1 == d2 {
    print("d1 and d2 are equal")
}

print("d1 + 0.1 is \(d1 + 0.1)")

if d1 + 0.1 == 1.2 {
    print("hello, out there.")
}
```

# Review and Wrapup

* Remember, (almost) always use ```Int```.
* What are the rare cases where using an integer type other than ```Int``` is recommended?


## References
http://images.esellerpro.com/2594/I/112/9/lrgscale4%20Way%20Stereo%20Input%20Selector2.jpg
[1]: http://images.esellerpro.com/2594/I/112/9/lrgscale4%20Way%20Stereo%20Input%20Selector2.jpg

https://en.wikipedia.org/wiki/Tuple
[2]: https://en.wikipedia.org/wiki/Tuple
