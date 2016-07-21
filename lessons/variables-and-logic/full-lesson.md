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
## Midday Check-in and solutions
TODO: RECAST as multiple choice.
* What types should we use for the following variables:
	* xxxxx - finish me 

* Declare a variable String, Int, Double, Bool

TODO: MOVE to end of day review
```swift
var healthyFood = "Broccoli"
var daysInCurrentMonth = 31
var currentTemperature = 88.5
```
* Declare a constant String, Int, Double
```swift
let numBoros = 5
TODO: finish
```
- Exercises and solutions (add links)
- Homework and solutions (add links)

# Lecture
## Intro
You might have visualized a variable as a box that can hold something. The box is a container that holds something "inside". It doesn't change but its contents might. What makes the box variable is that we can put different things in the box at different times.

This is true in some form or another in all (reasonable) programming languages. Swift has a couple distinguishing features about its approach to variables that are important to know. First, variables are strongly typed. Second there are constants that work just like variables but can only be set once.

## Types
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
TODO: Dump a bunch of var declarations here
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
TODO: Dump a bunch of var declarations here of the form
var salutation: String
salutation = "Dr. and Mrs. Foobar"
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
TODO: Dump a bunch of let declarations here
```
* Think of examples of where to use constants instead of variables.

# Review and Wrapup

* Define Type.
* Compare and contrast variables and constants.
* What are the benefits of types?

