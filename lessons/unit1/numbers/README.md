### Numbers & Operations:
---

### Objective
To be able to differentiate between number types (e.g `Int` vs `Float`), solve problems using integer operations, and apply newly learned information about numbers to conditionals.

### Readings

1. Swift Programming: The Big Nerd Ranch Guide, Chapter 4, Numbers
1. Apple's [Swift Language Reference, The Basics - Integers](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID317) 

---

### 1. Warmup

Simplify the following expressions [(PEMDAS Refresher)](https://www.mathsisfun.com/operation-order-pemdas.html):

```swift
4 + 3 * 5

3 / 3 * 2 + 5

2 ^ 6 - 5

5 + 4 / 2

9 - 3 * 4 - 2

4 * (-4) - 2

4 + 5 ^ 3 * 6 / 3
```

<details>
<summary><b>Click Here to Toggle Solution</b></summary>
```swift
4 + 3 * 5 // 19

3 / 3 * 2 + 5 // 7

2 ^ 6 - 5 // -1

5 + 4 / 2 // 7

9 - 3 * 4 - 2 // -5

4 * (-4) - 2 // -18

4 + 5 ^ 3 * 6 / 3 // 15
```
</details>

### 2. Intro to `Int`

Integer is a term borrowed (taken) from mathematics to describe a number that's not a fraction in the range from -∞ to +∞, including zero. Since computers don't really do infinity we change the definition, substituting minimum and maximum numbers for the infinities. 

The basic type for integers in Swift is `Int`. Before we explore the many related `Int` types it's important to note that for almost all cases it's considered best to use `Int`.

### 3. Integer Size

```swift
let minValue = UInt8.min  // minValue is equal to 0, and is of type UInt8
let maxValue = UInt8.max  // maxValue is equal to 255, and is of type UInt8
```

#### Exercise - Integer Size

Take the code block above and test different mins and maxes. Use `Int`, `Int8`, `Int16`, `Int32`, and `Int64`.

<details>
<summary><b>Click Here to Toggle Solution</b></summary>
```swift
let minInt8Value = Int8.min  // -128
let maxInt8Value = Int8.max  // 127

let minInt16Value = Int16.min  // -32768
let maxInt16Value = Int16.max  // 32767

let minInt32Value = Int32.min  // -2147483648
let maxInt32Value = Int32.max  // 2147483647

let minInt64Value = Int64.min  // -9223372036854775808
let maxInt64Value = Int64.max  // 9223372036854775807

let minIntValue = Int.min  // -9223372036854775808
let maxIntValue = Int.max  // 9223372036854775807

```
</details>

### 4. Signedness

A "signed" integer can be positive, negative or zero. An "unsigned" integer can only represent a positive number, or zero.

Swift offers unsigned versions of all the integer types. The main advantage of unsigned integers is that it doubles the size of the positive range of the type. This used to be more of an issue when memory was limited and squeezing every bit was a valuable optimization. Now, there are only some use cases that call for it. Similar to the specific Int sizes, controlling the signedness of integers has applications in networking where systems need to agree on the exact format of the data they're communicating.

**Question**: Think of applications that require using a very large number.

> * IDs on a popular service like Facebook and Twitter.
> * Scientific and mathematical applications that require exact precision.

#### Exercise - Signed/Unsigned Integers

Take the code block above and test different mins and maxes. Use `UInt`, `UInt8`, `UInt16`, `UInt32`, and `UInt64`.

<details>
<summary><b>Click Here to Toggle Solution</b></summary>
```swift
let minUInt8Value = UInt8.min  // 0
let maxUInt8Value = UInt8.max  // 255

let minUInt16Value = UInt16.min  // 0
let maxUInt16Value = UInt16.max  // 65535

let minUInt32Value = UInt32.min  // 0
let maxUInt32Value = UInt32.max  // 4294967295

let minUInt64Value = UInt64.min  // 0
let maxUInt64Value = UInt64.max  // 18446744073709551615

let minUIntValue = UInt.min  // 0
let maxUIntValue = UInt.max  // 18446744073709551615
```
</details>

Compare them to their corresponding signed type (e.g. `UInt8` to `Int8`).

<details>
<summary><b>Click Here to Toggle Solution</b></summary>
```
INSERT ANSER HERE -> Not sure how to answer
```
</details>


### 5. Creating Instances of `Int`

```swift
let numBonesInHumanBody = 206 // Int by default
let numLettersInEnglishAlphabet: Int8 = 26  // type annotation lets us control
```

---

### 6. Integer Operations

|Symbol| Operation          | Example | Result | 
|------|--------------------|---------|--------|
| +    | Addition           | 5 + 8   |  13    |
| -    | Subtraction        | 5 - 8   |  -3    |
| *    | Multiplication     | 5 * 8   | 40     |
| /    | Division           | 5 / 8   | 0      |
| %    | Modulo             | 5 % 8   | 5      |


### 7. Integer Division

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

#### Exercise - Integer Division: 
1. Try various division examples.
1. Try corresponding modulo examples.
1. Recreate the exact message below using calculations that use /, % and string interpolation:

```
12 / 5 = 2, remainder 2.
```

<details>
<summary><b>Click Here to Toggle Solution</b></summary>
```swift
// Example 1

var num1 = 25
var num2 = 4

let twentyFiveDivFour = num1 / num2 // Evaluates to: 6
let twentyFiveModFour = num1 % num2 // Evaluates to: 1
print("\(num1) / \(num2) = \(twentyFiveDivFour), remainder \(twentyFiveModFour).") // 25 / 4 = 6, remainder 1.

// Example 2

num1 = 76 // reassignment
num2 = 14 // reassignment

let seventySixDivFourteen = num1 / num2
let seventySixModFourteen = num1 % num2
print("\(num1) / \(num2) = \(seventySixDivFourteen), remainder \(seventySixModFourteen).") // 76 / 14 = 5, remainder 6.
```
</details>

### 8. Operator Shorthand

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

**Note**: You might see mention of the ++ and -- operators. They've been deprecated in Swift 3. 
Since ```i += 1``` offers the same functionality as ```i++``` it makes sense.

```swift
var i = 0 // 0
i += 1 // 1
```

### 9. Overflow Operators

You may see that Swift supports overflow operators. They're not used in everyday coding but the reason they exist is worth looking at quickly. Overflow refers to the result of trying to perform an operation that would result in a value that goes over the maximum, or under the minimum value of the data type.

```swift
var x: Int8 = 100
x += 30
```

That crashes, which is actually what we want it to do. This alerts us to the fact that we have overflow and we're more likely to fix it. There are operators that will make the value wrap around and our program won't crash but most likely the value we get is totally not what we expect.

**Takeaway**: Sometimes it's good to crash.

### 10. Conversion between Integer Types

The range of numbers that can be stored in an integer constant or variable is different for each numeric type. An Int8 constant or variable can store numbers between -128 and 127, whereas a UInt8 constant or variable can store numbers between 0 and 255. A number that will not fit into a constant or variable of a sized integer type is reported as an error when your code is compiled:

```swift
let cannotBeNegative: UInt8 = -1
// UInt8 cannot store negative numbers, and so this will report an error
let tooBig: Int8 = Int8.max + 1
// Int8 cannot store a number larger than its maximum value,
// and so this will also report an error
```

Because each numeric type can store a different range of values, you must opt in to numeric type conversion on a case-by-case basis. This opt-in approach prevents hidden conversion errors and helps make type conversion intentions explicit in your code.

To convert one specific number type to another, you initialize a new number of the desired type with the existing value. In the example below, the constant twoThousand is of type UInt16, whereas the constant one is of type UInt8. They cannot be added together directly, because they are not of the same type. Instead, this example calls UInt16(one) to create a new UInt16 initialized with the value of one, and uses this value in place of the original:

```swift
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)
Because both sides of the addition are now of type UInt16, the addition is allowed. The output constant (twoThousandAndOne) is inferred to be of type UInt16, because it is the sum of two UInt16 values.
```

### 11. Storage of Integers

[Binary Number System](https://www.mathsisfun.com/binary-number-system.html)

---

### 12. Floating Point Numbers

Floating-point numbers are used to represent the set of mathematical "real" numbers. 

Floating-point refers to the fact that the decimal point can be placed anywhere whithin the number. The computer stores floats in two parts: the mantissa and exponent. It could be an interesting math discussion but for our purposes we just need to know:

* Floating point numbers are very close approximations
* For a given data type they have a fixed precision. This limitation/power is exposed when you 
enter a very large or very small number

Swift has two floating-point types ```Float``` and ```Double```. Floats are stored in 32 bits and Doubles in 64. Hence double. Not double the size but double the precision. Double the fun? Not really.

```swift
let heightInMeters = 1.89 // Swift defaults to Double
let weightInKilos: Double = 111.34
let speedInKMP: Float = 66.7
```

### 13. Storage of Floating Point numbers

[Brief Explanation of the Representation of Floats in Memory](http://programmers.stackexchange.com/questions/215065/can-anyone-explain-representation-of-float-in-memory)

### 14. Beware of comparisons

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
### 15. Integer & Floating Point Conversion

Conversions between integer and floating-point numeric types must be made explicit:

```swift
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine
// pi equals 3.14159, and is inferred to be of type Double
```

Here, the value of the constant three is used to create a new value of type Double, so that both sides of the addition are of the same type. Without this conversion in place, the addition would not be allowed.

Floating-point to integer conversion must also be made explicit. An integer type can be initialized with a Double or Float value:

```swift
let integerPi = Int(pi)
// integerPi equals 3, and is inferred to be of type Int
Floating-point values are always truncated when used to initialize a new integer value in this way. This means that 4.75 becomes 4, and -3.9 becomes -3.
```

---

### 16. Review & Wrapup

* Remember, (almost) always use ```Int```.
* What are the rare cases where using an integer type other than ```Int``` is recommended?

