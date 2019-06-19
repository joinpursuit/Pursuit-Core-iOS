### Types, Variables, Logic and Operations
---



### Objectives
- To understand and differentiate among types of data, define constants and variables, print variables to the console using string interpolation, and to solve basic logic questions.
- To be able to differentiate between number types (e.g `Int` vs `Float`), solve problems using integer operations, and apply newly learned information about numbers to conditionals.


### Readings

1. Apple's [Swift Language Reference, The Basics](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309)


#### Further Readings
1. [Type Safety & Type Inference](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html) (seek for "Type Safety and Type Inference")

#### Resources
1. [Intro to App Development with Swift - Apple](https://itunes.apple.com/us/book/intro-to-app-development-with-swift/id1118575552?mt=11)

#### Vocabulary
1. **Variable** - stores information by pairing a unique name/identifier with a value. The value can later be accessed and mutated.
1. **Constant** - similar to a variable in that it stores values via a unique name, but the value that a constant stores is immutable (cannot be changed once it has been declared).
1. **Declaration** - determines the name and data type of a variable/constant, and specifies the properties of other elements.
1. **Initialization** -  the assignment of an initial value for a variable, constant, or object
1. **Type** - a classification of data which tells the compiler how the programmer intends to use the data. The variable's type defines the kind of operations that can be performed on and by it, the meaning of the data, and how the values of that type can be stored in memory.
1. **Type Annotation** - explicitly specifies the type of a variable or expression
1. **Type Inference** - allows the compiler to determine the type of a variable based on the value in the declaration, without any Type Annotation.
1. **Type Safe** - a type-safe language encourages you to be clear about the types of values your code can work with.
1. **Mutable** - a variable, or object, whose state can be modified at any time after its declaration.
1. **Immutable** - a variable, or object, whose state can not be changed once it has been declared.

---

### 1. Intro to Variables
You can visualize a variable as a box that can hold something. The box is a container that holds something "inside". The box itself doesn't change, but its contents might. What makes the box variable is that we can put different things in the box at different times.

This concept is true in some form or another in all (reasonable) programming languages. Swift has two important distinguishing features in its approach to variables. First, variables are **strongly typed**, meaning you can't change a variable's type after you declare it. Second, there are constants that work just like variables but can only be set once.

#### Variable Types
| Type | Explanation | Examples |
|:-:|:-:|:-:|
|Int|An integer. Can be positive, negative or zero.| 3, 0 -9|
|Double|A number with a decimal component| 3.2934, -39.99, 3.00|
|Character|A single Unicode character| "d", "!", "&#2400;"|
|String|Zero or more characters chained together|"Hello 6.1ers!", "", "Enter your username: "|
|Bool|A binary value that can either be true or false|true, false|

### 2. Declaring variables

Swift is a language with strong types and **type inference** during variable declaration.

```swift
var favoritePeanut = "Charlie Brown" // String
var theAnswer = 42 // Int
var singleFare = 2.75 // Double (Double for "double precision" Float)
```

#### Exercise - Declaring Variables

Declare some variables

<details>
	<summary><b><i>Click Here to Toggle Solution</i></b></summary>

```swift
//Int
var customersServed = 34
var statesNum = 50
var currentYear = 2016

//Double
var length = 60.4
var percentCompleted = 0.87
var gigawatts = 1.21

//Character
var grade = "A"
var punctuationSelected = "!"
var unicodePersonInChinese = "\u{4EBA}"

//String
var welcomeMessage = "Hi user! Thanks for downloading!"
var outOfBagels = "Error: no more bagels"
var exitMessage = "Thanks so much for playing!  Remember to rate our app!"

//Bool
var isValidPassword = false
var isLoggedIn = true
```
</details>

### 3. Type Annotations

Usually Swift will infer the type from an assignment. However, there is also a way to explicitly note the type. This practice is called **type annotation**. Even though assignment is the preferred way to define type, this form is both good to know and will be important later on, when we learn about function definitions.

```swift
var welcomeMessage: String = "Welcome Home"
var isLoggedIn: Bool = false
var numberOfLegos: Int = 293
```

#### Exercise - Type Annotations

Declare some variables using type annotations and set their value on the next line.

<details>
	<summary><b><i>Click Here to Toggle Solution</i></b></summary>

```swift
var salutation: String
salutation = "Dr. and Mrs. Foobar"

var isInArray: Bool
isInArray = false

var userID: Int
userID = 382

var hoursWorked: Double
hoursWorked = 15.5

var qMark: Character
qMark = "?"
```
</details>

### 4. Constants
As was introduced above, Swift distinguishes between variables and constants.

We define constants to protect the value from changing, which also makes the code more readable. When another programmer or "future you" sees a constant, you will know it's not meant to change.

The distinction between a constant and a variable is a basic computing idea, but in other languages constants are usually captured and communicated by some kind of convention, not built into the language like they are in Swift.

The keyword ```let``` is used in place of ```var```.

You might have visualized a variable as a box that can hold something; the box is the value. A constant's value is set the same way, but after the value has been set, it can't be changed. The advantage of this will become increasingly apparent as we use constants. At first, it might be easiest to think of its applications in math.

```swift
let pi = 3.1415926536
let e = 2.718281828459
let c = 299_792_458
```

These are mathematical and scientific constants (CS borrows the word) and they **never change**.

Similarly, in a program there are cases where you want something that, once set, cannot be reset.

#### Exercise - Constants

Declare some constants

<details>
	<summary><b><i>Click Here to Toggle Solution</i></b></summary>

```swift
//Int
let degreesInCircle = 360
let moonsOfMars = 2
let anglesInTriangle = 3

//Double
let acceleration = 9.8
let kgInPounds = 2.2
let nessieMoney = 3.50

//Character
let firstLetter: Character = "A"
let lastLetter: Character = "Z"
let questionMark: Character = "?"

//String
let testMsg = "This is the default testing message"
let fourScore = "Four score and seven years ago"
let goldenRecord = "We cast this message into the cosmos ... Of the 200 billion stars in the Milky Way galaxy, some – perhaps many – may have inhabited planets and space faring civilizations. If one such civilization intercepts Voyager and can understand these recorded contents, here is our message: This is a present from a small distant world, a token of our sounds, our science, our images, our music, our thoughts, and our feelings. We are attempting to survive our time so we may live into yours. We hope some day, having solved the problems we face, to join a community of galactic civilizations. This record represents our hope and our determination and our goodwill in a vast and awesome universe."

//Bool
let popeCatholic = true
let oceanPink = false
let codingFun = true
```
</details>

Think of examples of where to use constants instead of variables.

<details>
	<summary><b><i>Click Here to Toggle Solution</i></b></summary>

	```
	- A person's birthday
	- Pi
	```
</details>

---
### 5. Intro to Logic
We have seen that a `Bool` can either be true or false.  Sometimes we might want to check if an expression is true.  Let's say that we are hosting an event.  We have people attending this event, and chairs for them to sit in, which are both provided by the following declarations.
```swift
let numberOfPeople = 40
let numberOfChairs = 38
```
We want to know if we have enough chairs for everyone.  To be extra safe, we want to make sure we have more chairs than people! To do this, we can set a `Bool`:
```swift
let enoughChairsForEveryone = numberOfChairs > numberOfPeople
//enoughChairsForEveryone = 38 > 40
//enoughChairsForEveryone = false
```
If we had a different number of people or chairs, the `Bool` `enoughChairsForEveryone` would still accurately reflect if we had more chairs than people.

We've seen the symbol `'>'` as a comparison operator that means 'Greater than'.  Here's a list of other comparison operators that you'll often use when writing code:

|Symbol| Meaning| True examples | False example|
|:---:|:---:|:---:|:---:|
| < | Less than | 3 < 9 | 13 < -28 |
| > | Greater than| 120 > 34 | 4 > 3 * 2 |
| <= | Less than or equal to | 8 <= 8 | 10*2 <= 10 |
| >= | Greater than or equal to | -10 >= -10 | 3*0 >= 1 |
| == | Is equal to | 4.32 == 4.32 | - 12 == 12|
| != | Not equal to| 30 != 31 | 5 != 5|

<b>Practice</b>: Write 5 expressions that evaluate to <b>true</b> and 5 expressions that evaluate to <b>false</b>

We can also use logical operators like AND, NOT, and OR to make more complex statements.

|Symbol| Meaning| True examples | False example|
|:---:|:---:|:---:|:---:|
| ! | Not | !false | !true |
| && | And | true && true | true && false |
| &#124;&#124; | Or | true &#124;&#124; false | false &#124;&#124; false

We can create <b>truth tables</b> to show how these relationships play out.

Let's go ahead and create them now.

<details>
<summary><b><i>Click Here to Toggle Solution p && q</i></b></summary>

| p | q | p && q|
|:---:|:---:|:---:|
| true | true | true|
| true | false | false|
| false | true | false|
| false | false | false|

</details>

<details>
<summary><b><i>Click Here to Toggle Solution p &#124;&#124; q</i></b></summary>

| p | q | p &#124;&#124; q|
|:---:|:---:|:---:|
| true | true | true |
| true | false | true |
| false | true | true |
| false | false | false |
</details>

<details>
<summary><b><i>Click Here to Toggle Solution !p &#124;&#124; q</i></b></summary>

| p | q | !p &#124;&#124; q|
|:---:|:---:|:---:|
| true | true | true |
| true | false | false |
| false | true | true |
| false | false | true |
</details>


#### Exercise - Logic

For each Bool below, evaluate if it is true or false:

```swift
let isLessThan = 4 < 10
let isEqual = 5 == 5
let reverseIt = !false
let comboIt = !(9 > 2)
let isNotEqual = 3 != 3
```

<details>
	<summary><b><i>Click Here to Toggle Solution</i></b></summary>

```swift
let isLessThan = 4 < 10 // TRUE
let isEqual = 5 == 5 // TRUE
let reverseIt = !false // TRUE
let comboIt = !(9 > 2) // FALSE
let isNotEqual = 3 != 3 // FALSE
```
</details>

#### Integer Operators

We can also use arithmetic on integers.  We will go into more detail on integer operations later this week.

|Operator Symbol| Explanation |True Example|
|---|---|---|
| + | Addition | 4 + 3 == 7 |
| - | Subtraction | 3 - 9 == -6 |
| * | Multiplication | 4.1 * 2.2 == 9.02 |
| / | Division | 8 / 2 == 4 |
| % | Modulo (Remainder Operation) | 11 % 3 == 2 |

---

### 6. Order of Operations Review

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

2 ^ 6 - 5 // 59

5 + 4 / 2 // 7

9 - 3 * 4 - 2 // -5

4 * (-4) - 2 // -18

4 + 5 ^ 3 * 6 / 3 // 254 - note that evaluating exponents ("exponentiation") takes precedence
```
</details>

### 7. Intro to `Int`

Integer is a term borrowed (or taken!) from mathematics to describe a number that is not a fraction, in the range from -∞ to +∞. For example, 3, -3, and 0 (zero) are all integers. Since computers can't really reach infinity, we change the definition by substituting minimum and maximum numbers for the infinities.

The basic type for integers in Swift is `Int`. Before we explore the many related `Int` types it's important to note that **for almost all cases** it's considered best to use `Int`.


### 8. Creating Instances of `Int`

```swift
let numBonesInHumanBody = 206 // Int by default
let numLettersInEnglishAlphabet: Int8 = 26  // type annotation lets us control
```
---

### 9. Integer Operations

|Symbol| Operation          | Example | Result |
|------|--------------------|---------|--------|
| +    | Addition           | 5 + 8   |  13    |
| -    | Subtraction        | 5 - 8   |  -3    |
| *    | Multiplication     | 5 * 8   | 40     |
| /    | Division           | 5 / 8   | 0      |
| %    | Modulo             | 5 % 8   | 5      |


### 10. Integer Division

When dividing integers, the expression always evaluates to the whole part of the calculation.
You can think of this as always "dropping" or "throwing away" any numbers after the decimal point.

```swift
let nineDivThree = 9 / 3 //  3
let halfOfFive = 5 / 2 //  2, because 2.5 drops the decimal portion
```

There is a partner operator to pick up that remainder, called the modulo (sometimes called modulus).

```swift
let nineDivThree = 9 % 3 //  0
let halfOfFive = 5 % 2 //  1
```

#### Exercise - Integer Division:
1. Try various division examples.
1. Try corresponding modulo examples.
1. Recreate the exact message below using calculations that use /, % and string interpolation:

`12 / 5 = 2, remainder 2.`

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

### 11. Operator Shorthand

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
| %=    | Mod and assign        | i %= 3   |   1    |

**Note**: You might see mention of the `++` and `--` operators. They are common in many other programming languages, but have been deprecated since Swift 3 (a long time ago, in coding years).

Since ```i += 1``` offers the same functionality as ```i++```, this makes sense.

```swift
var i = 0 // 0
i += 1 // 1
```


### 12. Floating Point Numbers

Floating-point numbers are used to represent the set of mathematical "real" numbers.

Floating-point refers to the fact that the decimal point can be placed anywhere within the number. The computer stores floats in two parts: the mantissa and exponent. This could be an interesting math discussion, but for our purposes we just need to know:

* Floating point numbers are very close approximations of decimal numbers.
* For a given data type they have a fixed precision. This limitation/power is exposed when you
enter a very large or very small number

Swift has two floating-point types ```Float``` and ```Double```. `Floats` are stored in 32 bits and `Doubles` in 64. Hence a "double". Not double the size, but double the precision. Double the fun? Not really.

```swift
let heightInMeters = 1.89 // Swift defaults to Double
let weightInKilos: Double = 111.34
let speedInKMP: Float = 66.7
```

### 13. Storage of Floating Point numbers

[Brief Explanation of the Representation of Floats in Memory](http://programmers.stackexchange.com/questions/215065/can-anyone-explain-representation-of-float-in-memory)

### 14. Beware of comparisons

Because floating-points are always approximations, exact comparisons sometimes don't give expected results.

```swift
let d1 = 1.1
let d2 = 1.1

if d1 == d2 {
    print("d1 and d2 are equal")
}

print("d1 + 0.1 is \(d1 + 0.1)")

if d1 + 0.1 == 1.2 {
    print("hello, out there.")
} else {
  print("d1 + 0.1 is not 1.2")
}
```
### 15. Integer & Floating Point Conversion

Integers and floating-point numbers are different types, and cannot be used interchangeably. Instead, we can explicitly convert between integer and floating-point numeric types:

```swift
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine
// pi equals 3.14159, and is inferred to be of type Double
```

Here, the value of the constant three is used to create a new value of type `Double`, so that both constants being added are of the same type. Without this conversion "in place", the addition would not be allowed.

Floating-point to integer conversion must also be made explicit. An integer type can be initialized with a Double or Float value:

```swift
let integerPi = Int(pi)
// integerPi equals 3, and is inferred to be of type Int
Floating-point values are always truncated when used to initialize a new integer value in this way. This means that 4.75 becomes 4, and -3.9 becomes -3.
```

---

### Review & Wrapup

* Define Type.
* Compare and contrast variables and constants.
* What are the benefits of types?
* Remember, (almost) always use `Int`.
* What are the rare cases where using an integer type other than `Int` is recommended?

### Standards

IOS: IOS.1

Language Fundamentals: LF.1, LF.1.a, LF.2
