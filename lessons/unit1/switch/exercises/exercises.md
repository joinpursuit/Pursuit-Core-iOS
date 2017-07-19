### Switch Exercises
---

#### Exercise 1.
What are some reasons to use a switch instead of an if?

<details>
<summary><b>Solution</b></summary>

> - When there is a known set of values a conditional is testing for
> - When there are a known set of ranges that can be matched against
> - To match tuple patterns
> - Reads better (this is usually the result of the previous reasons)

</details>

#### Exercise 2.
What's missing from the switch statement below?

a. The case statement needs to say month == 1
b. The code is valid and not missing anything
c. The code will not compile because switch statements need case statements for all expected values, or a default statement.

```swift
let monthNum = 3
switch monthNum {
case 1:
    print("January")
}
```

<details>
<summary><b>Solution</b></summary>

> c. The code will not compile because switch statements need case statements for all expected values, or a default statement.

</details>

#### Exercise 3.
Convert the if/else statement below into a switch statement.

```swift
let temperatureInFahrenheit = 72

if temperatureInFahrenheit <= 40 {
    print("It's cold out.")
} else if temperatureInFahrenheit >= 85 {
    print("It's really warm.")
} else {
    print("Weather is moderate.")
}
```

<details>
<summary>Solution</summary>
    
```swift
switch temperatureInFahrenheit {
case let t where t <= 40:
    print("It's cold out.")
case let t where t >= 85:
    print("It's really warm.")
default:
    print("Weather is moderate.")
}
```

</details>

#### Exercise 4.
Change the below if/else statement into a switch statement.

```swift
let cardNum = 12
if cardNum == 11 {
    print("Jack")
} else if cardNum == 12 {
    print("Queen")
} else if cardNum == 13 {
    print("King")
} else {
    print(cardNum)
}
```

<details>
<summary>Solution</summary>

```swift
switch cardNum {
case 11:
    print("Jack")
case 12:
    print("Queen")
case 13:
    print("King")
default:
    print(cardNum)
}
```

</details>

#### Exercise 5.
Create a switch statement that will convert a number grade into a letter grade as shown below:

| Numeric Score | Letter Grade |
| :----------:  | :----------: |
| 100 | A+|
| 90  - 99 |  A |
| 80 - 89 | B |
| 70 - 79 | C |
| 65 - 69 | D |
| Below 65 | F |

<details>
<summary>Solution</summary>

```swift
let grade = 90

switch grade {
case 100:
    print("A+")
case grade where grade >= 90  && grade <= 99:
    print("A")
case grade where grade >= 80 && grade <= 89:
    print("B")
case grade where grade >= 70 && grade <= 79:
    print("C")
case grade where grade >= 65 && grade <= 69:
    print("D")
case grade where grade < 65 && grade >= 0 && grade < 101:
    print("F")
default:
    print("Grade must be in the range 0-100")
}
```

</details>

#### Exercise 6.
Consider the switch statement below. What is the output as written? What happens when you change `number` to 365? 1024? 65? What happens when you remove the __default__ case?
```swift
let number = 42

switch number {
case 365:
    print("Days in year")
case 1024:
    print("Bytes in a Kilobyte")
case 0:
    print("Where arrays start")
case 42:
    print("The answer to life, the universe and everything")
default:
    print("Some uninteresting number")
}
```

<details>
<summary>Solution</summary>

```swift
nummber = 42 // Output: "The answer to life, the universe and everything"
number = 365 // Output: "Days in year"
number = 1024 // Output: "Bytes in a Kilobyte"
number = 65 // Output: "Some uninteresting number"
```

>If we remove the default case, we will get a runtime error becuase the switch statement is no longer exhaustive. The default case tells us what to do in the event that the value we are switching on does not match any of the existing cases. Because `number` is an `Int`, it can potentially be any digit in the range between Int.min (-9,223,372,036,854,775,808) and Int.max (9,223,372,036,854,775,807). The default case gives us the power to only specify the cases we care about, while performing some arbitrary action if none of those specified cases are met.

</details>

#### Exercise 7.
Consider the variable below called `population` and the if-condition.
a. Add an else-if-condition that states if `population` is less than 10000 but greater than 5000, then `message` changes to say it's "a medium size town".
b. Add an else-condition where `message` changes to say it's a mid-size town.
c. Convert your final if-else statement to a switch statement.

```swift
var population: Int = 10000
var message = String()

if population > 10000 {
    message = "\(population) is a large town"
}
```

<details>
<summary>Solution</summary>

```swift
var population: Int = 10000
var message = String()

if population >= 10000 {
    message = "\(population) is a large town"
} else if population < 10000 && population > 5000 {
    message = "\(population) is a medium size town"
} else {
    message = "\(population) is a mid-size town"
}

switch population {
case population where population >= 10000:
    message = "\(population) is a large town"
case population where population < 10000 && population > 5000:
    message = "\(population) is a medium size town"
default:
    message = "\(population) is a mid-size town"
}
```

</details>

#### Exercise 8.
Complete the code below so that it prints out and tells the user if the sum of the two numbers in the tuple is at least 15.
a. Using a conditional
b. Using a switch statement

```swift
let myTuple: (Int, Int) = (5, 10)
```

<details>
<summary>Solution</summary>

```swift
let tupleSum = myTuple.0 + myTuple.1

if tupleSum >= 15 {
    print("Sum is at least 15!")
} else {
    print("Sum is less than 15 :(")
}

switch tupleSum {
case tupleSum where tupleSum >= 15:
    print("Sum is at least 15!")
default:
     print("Sum is less than 15 :(")
}
```

</details>

#### Exercise 9.
Complete the switch statement below.  We want it to output a personalized greeting to the student based on their name and class.

```swift
let studentNameAndClass = ("Ben", 3.2)
switch studentNameAndClass {
   //YOUR CODE GOES HERE...
}
```

<details>
<summary>Solution</summary>

```swift
switch studentNameAndClass {
case let (studentName, cohort):
    print("Hey \(studentName)! Welcome to Access Code \(cohort)!")
}
```

</details>

#### Exercise 10.
Consider the below switch with a tuple.
a. Add a case for when `y` is __double__ the value of `x`.
b. Add a case for when `y` is __triple__ the value of `x`.

```swift
switch (x,y) {
case let (x,y) where x == y:
    print("x is equal to y")
case let (x,y):
    print("Nothing is special about this tuple")
}
```

<details>
<summary>Solution</summary>

```swift
let tupleTen = (9,27)

switch tupleTen {
case let (x,y) where x == y:
    print("x is equal to y")
case let (x,y) where y == x*2:
    print("y is double the value of x")
case let (x,y) where y == x*3:
    print("y is triple the value of x")
case let (x,y):
    print("Nothing is special about this tuple")
}
```

</details>

#### Exercise 11.
Write an `if` statement that checks to see what quadrant a point is in, then prints that quadrant.
Then write it as a `switch` statement.

```swift
let myPoint: (Double, Double)
```

<details>
<summary>Solution</summary>

```swift
let myPoint: (Double, Double) = (2.0, -5.0)

if myPoint.0 >= 0 && myPoint.1 > 0 {
    print("\(myPoint) is in Quadrant 1")
} else if myPoint.0 <= 0 && myPoint.1 > 0 {
    print("\(myPoint) is in Quadrant 2")
} else if myPoint.0 <= 0  && myPoint.1 < 0 {
    print("\(myPoint) is in Quadrant 3")
} else if myPoint.0 >= 0 && myPoint.1 < 0 {
    print("\(myPoint) is in Quadrant 4")
} else if myPoint.0 == 0 && myPoint.1 == 0 {
    print("\(myPoint) is the Origin")
} else {
    print("\(myPoint) does not fall in any Quadrant. Maybe it falls on a line?")
}

switch myPoint {
case let (x,y) where x >= 0 && y > 0:
    print("\(myPoint) is in Quadrant 1")
case let (x,y) where x <= 0 && y > 0:
    print("\(myPoint) is in Quadrant 2")
case let (x,y) where x <= 0 && y < 0:
    print("\(myPoint) is in Quadrant 3")
case let (x,y) where x >= 0 && y < 0:
    print("\(myPoint) is in Quadrant 4")
case let (x,y) where x == 0 && y == 0:
    print("\(myPoint) is the Origin")
default:
    print("\(myPoint) does not fall in any Quadrant. Maybe it falls on a line?")
}
```

</details>

#### Exercise 12.
Write an if statement that prints out what decade of life someone is in (e.g "You are in your twenties).
Then, write it as a switch statement.

```swift
let nameAndBirthYear: (String, Int)
```

<details>
<summary>Solution</summary>

```swift
nameAndBirthYear = ("Erica", 27)

//if-statement with ranges
if (1...9).contains(nameAndBirthYear.1) {
    print("\(nameAndBirthYear.0), you're still a baby! Here's some apple juice sweetie.")
} else if (10...19).contains(nameAndBirthYear.1) {
    print("\(nameAndBirthYear.0), you are in your teens")
} else if (20...29).contains(nameAndBirthYear.1) {
    print("\(nameAndBirthYear.0), you are in your twenties")
} else if (30...39).contains(nameAndBirthYear.1) {
    print("\(nameAndBirthYear.0), you are in your thirties")
} else if (40...49).contains(nameAndBirthYear.1) {
    print("\(nameAndBirthYear.0), you are in your forties")
} else if (50...59).contains(nameAndBirthYear.1) {
    print("\(nameAndBirthYear.0), you are in your fifties")
} else if (60...69).contains(nameAndBirthYear.1) {
    print("\(nameAndBirthYear.0), you are in your sixties")
} else if (70...79).contains(nameAndBirthYear.1) {
    print("\(nameAndBirthYear.0), you are in your seventies")
} else if (80...89).contains(nameAndBirthYear.1) {
    print("\(nameAndBirthYear.0), you are in your eighties")
} else if (90...99).contains(nameAndBirthYear.1) {
    print("\(nameAndBirthYear.0), you are in your nineties")
} else if nameAndBirthYear.1 >= 100 {
    print("\(nameAndBirthYear.0), you are \(nameAndBirthYear.1) years old! What's your secret? Are you immortal?")
}


switch nameAndBirthYear {
case let (name, age) where (1...9).contains(age):
    print("\(name), you're still a baby! Here's some apple juice sweetie.")
case let (name, age) where (10...19).contains(age):
    print("\(name), you are in your teens")
case let (name, age) where (20...29).contains(age):
    print("\(name), you are in your twenties")
case let (name, age) where (30...39).contains(age):
    print("\(name), you are in your thirties")
case let (name, age) where (40...49).contains(age):
    print("\(name), you are in your forties")
case let (name, age) where (50...59).contains(age):
    print("\(name), you are in your fifties")
case let (name, age) where (60...69).contains(age):
    print("\(name), you are in your sixties")
case let (name, age) where (70...79).contains(age):
    print("\(name), you are in your seventies")
case let (name, age) where (80...89).contains(age):
    print("\(name), you are in your eighties")
case let (name, age) where (90...99).contains(age):
    print("\(name), you are in your nineties")
case let (name, age) where age >= 100:
    print("\(name), you are \(age) years old! What's your secret? Are you immortal?")
default:
    print("Uhhm... Give me a real age please!")
}
```

</details>

#### Exercise 13.
Write a switch statement that switches on a tuple with two Bools `(Bool, Bool)` and prints the logical operators (i.e. "&&", or "||") that could be applied to make a true expression.

```swift
let pAndQ: (Bool, Bool)
```
<details>
    <summary>Solution</summary>

```swift
let pAndQ: (Bool, Bool) = (false, false)
//let pAndQ: (Bool, Bool) = (true, true)
//let pAndQ: (Bool, Bool) = (true, false)
//let pAndQ: (Bool, Bool) = (false, true)

switch pAndQ {
case (true, true):
    print("|| or &&")
case (false, false):
    print("No way to true without ! (not)")
case (true, false), (false, true):
    print("||")
}
```

</details>

Next, write a switch statement that switches on a tuple with 3 Bools `(Bool, Bool, Bool)` and prints what logical operators (i.e. "&&", or "||") could connect all Bools with to make a true expression.

```swift
let pAndQAndR: (Bool, Bool, Bool)
```

<details>
<summary>Solution</summary>

```swift
switch pAndQAndR {
case (true, true, true):
    print("|| or &&")
case (false, true, true), (true, false, true), (true, true, false), (false, true, false), (false, false, true), (true, false, false):
    print("||")
case (false, false, false):
    print("No way to true without ! (not)")
}
```

</details>


#### Exercise 14.
Write a conditional statement that prints out whether a number is a whole number.

<details>
<summary>Solution</summary>

```swift
let num = 5

if floor(Double(num)) == Double(num) { //works whether num is an Int or a Double
    print("\(num) is a whole number")
} else {
    print("\(num) is not a whole number")
}
```

</details>

#### Exercise 15.
You're walking in Manhattan. Streets go East-West and Avenues go North-South. Write a `switch` statement that switches on a String named `direction` having one of the values "North", "East", "West", or "South" and tells you if you're on a street or avenue (e.g. if `direction` has the value "West" you should print "street").

<details>
<summary>Solution</summary>

```swift
let direction = "North"

switch direction {
case direction where direction == "North" || direction == "South":
    print("avenue")
case direction where direction == "East" || direction == "West":
    print("street")
default:
    print("unknown location")
    
}
```

</details>
 
