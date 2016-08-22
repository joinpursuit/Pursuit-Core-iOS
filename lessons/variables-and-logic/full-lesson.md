# Standards 
Understand and use fundamental data types

# Objectives
Students will be able to:
* Differentiate among types of data
* Define constants and variables
* Print variables to the console using string interpolation
* Solve basic logic questions

# Resources
Swift Programming: The Big Nerd Ranch Guide, Chapter 2

Apple's [Swift Language Reference, The Basics](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309

# Assessment Materials
## [Prework HW](https://docs.google.com/forms/d/e/1FAIpQLSf6Ocyz-H8mu4KpCzhCdIDaoKY9ZzypOh3a7tF9YmBUySnBuQ/viewform)
## [Midday Check-in and solutions](https://goo.gl/forms/exuAHSxaHwTFWApD3)

```swift
var healthyFood = "Broccoli"
var daysInCurrentMonth = 31
var currentTemperature = 88.5
```
* Declare a constant String, Int, Double
```swift
let numBoros = 5
let alertMessage = "Warning!"
let conversionRate = 2.54
```
- Exercises and solutions (add links)
- Homework and solutions (add links)

# Lecture
## Intro
You might have visualized a variable as a box that can hold something. The box is a container that holds something "inside". It doesn't change but its contents might. What makes the box variable is that we can put different things in the box at different times.

This is true in some form or another in all (reasonable) programming languages. Swift has a couple distinguishing features about its approach to variables that are important to know. First, variables are strongly typed. Second there are constants that work just like variables but can only be set once.

##Variable types
|Variable type | Explanation | Examples |
|---|---|---|
|Int|An integer.  Can be positive, negative or zero.| 3, 0 -9|
|Double|A number with a decimal component| 3.2934, -39.99, 3.00|
|Character|A single Unicode character| "d", "!", "&#2400;"|
|String|Zero or more characters chained together|"Hello Access Code!", "", "Enter your username: "|
|Bool|A binary value that can either be true or false|true, false|

## Declaring variables
Swift is a language with strong types and type inference during variable declaration.

```swift
var favoritePeanut = "Charlie Brown" // String
var theAnswer = 42 // Int
var singleFare = 2.75 // Double (double is an unfortunate legacy)

// by the way, this is a comment
/* this, too, is a comment */
/* and this kind is more
   interesting that it can span lines */
/* one use of the multiline comment is to "comment out" large
   blocks of code that you might not want to run during testing */
```

#### Exercise

* Declare some variables

```swift
//Int
var customersServed = 34
var statesNum = 50
var currentYear = 2016
//Double
var length = 60.4
var percentCompleted = .87
var gigawatts = 1.21
//Character
var grade = "A"
var punctuationSelected = "!"
var unicodePersonInChinese = "\u{4EBA}"
//String
var welcomeMessage = "Hi user!  Thanks for downloading!"
var outOfBagels = "Error: no more bagels"
var exitMessage = "Thanks so much for playing!  Remember to rate our app!"
//Bool
var isValidPassword = false
var isLoggedIn = true
```

### Type Annotations

Usually Swift will infer the type from an assignment but there's also a way to explicitly note the type. This is called type annotations. Even though the assignment is the preferred way to define type this form is both good to know and will come back later in function definitions.

```swift
var welcomeMessage: String
var isLoggedIn: Bool
var numberOfLegos: Int
```

#### Exercise

* Declare some variables using type annotations and set their value on the next line.

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

## Constants
As was introduced above, Swift distinguishes between variables and constants.

The distinction is a basic computing idea, but in other languages constants are usually captured and communicated by means of convention, not built into the language.

We define constants to protect the value from changing, which also makes the code more readable. When another programmer, or future you sees that something is a constant you know it's not meant to change.

The keyword ```let``` is used in place of ```var```.

You might have visualized a variable as a box that can hold something; the box is the value. A constant's value is set the same way but after it's been set it can't be changed. The advantage of this will become increasingly apparent as we use it. At first, it might be easiest to think of its applications in math.

```swift
let pi = 3.1415926536
let e = 2.718281828459
let c = 299_792_458
``` 

These are mathematical and scientific constants (CS borrows the word) and they never change. 

But in a program there are cases where you want something, once set, to not be reset. 

#### Exercise
* Declare some constants
```swift
//Int
let degreesInCircle = 360
let moonsOfMars = 2
let anglesInTriange = 3
//Double
let acceleration = 9.8
let kgInPounds = 2.2
let nessieMoney = 3.50
//Character
let firstLetter: Character = "A"
let lastLetter: Character = "Z"
let questionMark: Characger = "?"
//String
let testmsg = "This is the default testing message"
let fourScore = "Four score and seven years ago"
let goldenRecord = "We cast this message into the cosmos ... Of the 200 billion stars in the Milky Way galaxy, some – perhaps many – may have inhabited planets and space faring civilizations. If one such civilization intercepts Voyager and can understand these recorded contents, here is our message: This is a present from a small distant world, a token of our sounds, our science, our images, our music, our thoughts, and our feelings. We are attempting to survive our time so we may live into yours. We hope some day, having solved the problems we face, to join a community of galactic civilizations. This record represents our hope and our determination and our goodwill in a vast and awesome universe."
//Bool
let popeCatholic = true
let oceanPink = false
let codingFun = true
```
* Think of examples of where to use constants instead of variables.


##Logic
We have seen that a Bool can either be true or false.  Sometimes we might want to check if an expression is true.  Let's say that we are hosting an event.  We have people attending this event, and chairs for them to sit at given by the following declarations.
```swift
let numberOfPeople = 40
let numberOfChairs = 38
```
We know want to know if we have enough chairs for everyone.  To be extra safe, we want to make sure we have more chairs than people.  To do this, we can set a Bool:
```swift
let enoughChairsForEveryone = numberOfChairs > numberOfPeople
//enoughChairsForEveryone = 38 > 40
//enoughChairsForEveryone = false
```
If we had a different number of people or chairs, the Bool enoughChairsForEveryone would still accurately reflect if we had more chairs than people.

We've seen the symbol '>' as a comparison operator that means 'Greater than'.  Here's a list of other comparison operators that you'll use when writing code:

|Symbol| Meaning| True examples | False example|
|---|---|---|---|
| < | Less than | 3 < 9 | 13 < -28 |
| > | Greater than| 120 > 34 | 4 > 3 * 2 |
| <= | Less than or equal to | 8 <= 8 | 10*2 <= 10 |
| >= | Greater than or equal to | -10 >= -10 | 3*0 >= 1 |
| == | Is equal to | 4.32 == 4.32 | - 12 == 12|
| != | Not equal to| 30 != 31 | 5 != 5|

We can also use logical operators like AND, NOT, and OR to make more complex statements.

|Symbol| Meaning| True examples | False example|
|---|---|---|---|
| ! | Not | !false | !true |
| && | And | true && true | true && false |
| &#124;&#124; | Or | true &#124;&#124; false | false &#124;&#124; false

The truth tables below give more detail.  (P means the first expression and Q means the second expression)

| p | q | p && q|
|---|---|---|
| true | true | true| 
| true | false | false|
| false | true | false|
| false | false | false|

| p | q | p &#124;&#124; q|
|---|---|---|
| true | true | true | 
| true | false | true |
| false | true | true |
| false | false | false |


#### Exercises
For each Bool below: evaluate if it is true or false:

```swift
let isLessthan = 4 < 10
let isEqual = 5 == 5
let reverseIt = !false
let comboIt = !(9 > 2)
let isntEqual = 3 != 3
```

####Integer Operators
We can also use arithmatic on integers.  We will go into more detail on integer operations later this week.

|Operator Symbol| Explanation |True Example|
|---|---|---|
| + | Addition | 4 + 3 == 7 |
| - | Subtraction | 3 - 9 == -6 |
| * | Multiplication | 4.1 * 2.2 == 9.02 |
| / | Division | 8 / 2 == 4 |
| % | Modolo (Remainder Operation) | 11 % 3 == 2 |


# Review and Wrapup

* Define Type.
* Compare and contrast variables and constants.
* What are the benefits of types?

