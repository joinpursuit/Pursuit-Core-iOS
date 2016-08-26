# AC3.2 Week 2 Assessment

This is a closed-book assessment.  Do not use computers, phones, Google,
StackOverflow, or any other resources other than your brain!

Please answer all questions.

## Environment, Tools & Resources

**QE1.** Given that you've made changes you now want to include in a pull request, 
what is the correct order of these three git commands:
```commit```, ```push```, and ```add```?

## Variables, Constants and Logic

**QV1.** Name six types in the Swift language.

**QV2.** What is the type of each variable in the code below:

```swift
a. var height = 76.7
b. var age = 19
c. var found = true
d. var zipCodes: [Int]
e. var containsColor = ["red":true, "blue":false, "green":true]
```

**QV3.** True or False: Constants are mutable.

**QV4.** What do each of the following Boolean expressions evaluate to?

```swift
a. true && true
b. false || true
c. true && false
d. true && !false
e. !false && (!true || true)
```

## Numbers & operations
**QN1.** Identify the following operator symbols using the word bank on the answer sheet. Then, write
in the number of operands.

E.g. 
```
+  addition 2 operands
```

```
= 
- 
!=
* 
>=
+ 
% 
< 
==
/ 
! 
```

## Loops

**QL1.**  Write a ```while``` loop that prints the numbers 1 through 10. There's more than
one way to do this. Any working solution is fine.

**QL2.**  Write a ```for```` loop that calculates the sum of all numbers 1 through 10 and prints it.

**QL3.** What will the following nested loop output:

```swift
for i in 1...5 {
    for j in 1...5 {
        print(i * j, terminator: "  ")
    }
    print("")
}
```

## Strings, Unicode

**QS1.** Given the string ```aSentence```, below, write code that prints the number of vowels in 
the string. Vowels include 'a', 'e', 'i', 'o', and 'u', but not 'y'.

```swift
let aSentence = "Whatever you are, be a good one." // should print 13
```

**QS2.** Given the information: COMBINING TILDE (U+0303), alter the initialization of the constant 
```tomorrow```, below, to make it correct Spanish. Hint, the first n gets the tilde.

```swift
let tomorrow = "manana"
```

## Conditionals

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

## Optionals

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

to a constant and use it to print to the console using string interpolation so the final output is:

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

## Arrays

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

**QA4.** Continuing with the ```allArrays``` variable used in the prior two questions, 
what happens when you add ```array4``` to it, as in:

```swift
let array4 = [1,2,3]
let anotherArray = allArrays + array4
```

## Dictionaries

**QD1.** Given the Dictionary ```subwayColors``` below, add elements to it for the 3 train
and the 6 train. (Don't add by re-writing the initialization.)

```swift
var subwayColors = [1:"red", 2:"red", 4:"green", 5:"green", 7:"purple"]
```

**QD2.** Redefine ```subwayColors``` so that it would be able to hold all NYC Subway trains including,
for example, the 1, 2, 3 and N, Q, and R trains. 


**QD3.** Remove the outdated 9 train from ```seventhAvenueTrainsInThe90s```, again, in a subsequent operation and
not by simply altering the initialization.

```swift
var seventhAvenueTrainsInThe90s = [1:"red", 2:"red", 3:"red", 9:"red"]
```
