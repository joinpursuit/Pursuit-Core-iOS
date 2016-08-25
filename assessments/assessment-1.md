# AC3.3 Week 2 Assessment

This is a closed-book assessment.  Do not use computers, phones, Google,
StackOverflow, or any other resources other than your brain!

Please answer all questions.

## Environment, Tools & Resources, Pair programming

**QE1.** What does ```commit``` do?

**QE2.** Given that you've made changes you now want to include in a pull request, 
what is the correct order of these three git commands:
```commit```, ```push```, and ```add```?

## Variables/constants, interpolation, logic, types, constants

**QT1.** Name four types

**QT2.** What type is ```height``` in the code below:

```swift
var height = 76.7
```

### Numbers & operations
**QN1.** Match these operator symbols with the description of the operation. Write
in the number of operands

E.g. 
```
+  addition  2 operands
```

```
=                not
-                multiplication
!=               subtraction
*                test for equality
>=               assignment
%                greater than or equal to
<                division
==               modulo
/                equality
!                less than
```

### For loops, while loops

**QL1.**  Write a loop that prints the numbers 1 through 10.

**QL2.**  Write a loop that that prints the numbers 1 through n.

**QL3.**  Write a loop that prints the even numbers 2 through n.

**QL4.**  Write a loop that prints the sum of all numbers 1 through 10.

**QL5.**  Create a loop from 0 to 20. Using a _switch_ statement, if the N is odd, 
print "Odd" and if even, print "Even."

**QL6.** Create a loop from 0 to 20. Create a bool variable __multipleOf3__ 
Using a _switch_ statement, if N is a multiple of 3, set your bool to _true_, 
if not set it to _false_.

**QL7.** Create a loop from 0 to 30. If N is odd and a multiple of 5,
 print "Odd and Multiple of 3", otherwise print "Neither."


**QL8.**  Given a string __xAndO__ and bool __isEqual__ write a loop that checks to see if the string has the same amount of "X" and "O", if so __isEqual__ is set to _true_, else _false_. Your check should be case sensitive.

```
example:
let xAndO = "xXxXoOoO" // isEqual should be true
let xAndO = "xOxoX" // isEqual should be false
```
ve "Illinois" and "Kansas" from the array below.

var westernStates = ["California", "Oregon", "Washington", "Idaho", "Illinois", "Kansas"]


//Write all your code below:

//3)
//Iterate through the array below.  For each each state, print out whether or not it is in the continental United States.

let moreStates = ["Hawaii", "New Mexico", "Alaska", "Montana", "Texas", "New York", "Florida"]

//Write all your code below:

# Strings, Unicode

Consider this block of Swift for the following two questions.

```swift
        let name = "Andrea"
        let age = 23
        print("My name is \(name + " and my age is\(age)")")
```
**QS1.** Would you say the interpolated strings are
      
a) incorrect and will result in error
 
b) nested

c) of type Double

d) Optionals

**QS2.** Rework the interpolation in the previous question using simpler, better style.

**QS3.** Given a string ```word```, if ```word``` has an even number of letters 
capitalize the entire string, or if ```word``` is an odd number of letters 
lowercase the entire string.

```swift
var word = "planet" //should turn to "PLANET"
var word = "Jupiter" //should turn to "jupiter"
```

# Conditionals

**QC1.** Build a ```switch``` that translates a student's numerical score into a letter grade 
according to the following criteria:

```
- score = 100 -> "Perfect score!"
- score >= 90 -> "A" 
- score >= 80 -> "B" 
- score >= 70 -> "C"
- score >= 60 -> "D"
- score >=  0 -> "Fail"
```

# Optionals

**QO1.** What will the following block of code print to the console?

```swift
var vegetable: String?
print(vegetable)
vegetable = "Tomato"
print(vegetable)
print(vegetable!)
```

**QO2.** Bind the ```color``` variable, 


```swift
var color: String = "Crimson"
```

to a constant and print it to the  console using string interpolation so the final output is:

```
In The Court of the Crimson King
```


For _**QO3. - Q06.**_ Consider this code block:

```swift
var bookReviewCount: Int?
var avgStarRating: Double?
var bookTitle: String

// set variables here


if let count = bookReviewCount, rating = avgStarRating {
    if (rating > 3) {
        print("\(bookTitle): \(rating) stars")  // 1
    }
    else {
        print("\(bookTitle) is not getting good reviews") // 2
    }
}
else {
    print("\(bookTitle) is a new or unpopular book") // 3
}
```

**QO3.** What happens with the code as it is now?

**QO4.** Set **any or all** of the three variables ```bookReviewCount```, ```avgStarRating```,
and ```bookTitle``` below the "set variables here" comment
so that the first message (marked with // 1) would be printed.

e.g. (not necessarily the right answer. Hint: definitely not the right answer):

```
bookReviewCount = 2
avgStarRating = 1.1
bookTitle = "War and Peace"
```

**QO5.** Provide values for the same three variables that would result in the second message (marked with // 2) to be printed.

**QO6.** Provide values for the same three variables that would result in the third message (marked with // 3) to be printed.

# Strings

**QS4.** Given a string ```aSentence```, write code that prints the number of vowels in 
the string. Vowels include 'a', 'e', 'i', 'o', and 'u', but not 'y').

```swift
let aSentence = "Whatever you are, be a good one." // should print 13
```

### Arrays

**QA1.** Given the array ```animals``` below, write code that finds and prints the longest word in the array.

```swift
let animals = ["dog", "cat", "bat", "octupus"] // should print "octupus"
```

**QA2.** Given ```array1```, ```array2```, ```array3```, combine the three arrays 
into a new array, ```allArrays```.

```
let array1 = ["Hello", "there,"]
let array2 = ["how", "are", "you"]
let array3 = ["let's", "code", "!"]
```

**QA3.** Using the ```allArrays``` variable you just defined in the previous question, write
a for loop that will print it as a single sentence with natural spacing.

**QA4.** See __array4__ below. What happens when you add __array4__ to __allArrays__?
```
let array4 = [1,2,3]
```

### Dictionaries


