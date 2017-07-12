### Switch Exercises
---

#### Exercise 1.
What are some reasons to use a __switch__ instead of an __if__?

<details>
<summary><b>Solution</b></summary>

- When there is a known set of values a conditional is testing for
- When there are a known set of ranges that can be matched against
- To match tuple patterns
- Reads better (this is usually the result of the previous reasons)

</details>

#### Exercise 2.
What's missing from the switch statement below?

- a. The case statement needs to say month == 1
- b. The code is valid and not missing anything
- c. The code will not compile because switch statements need case statements for all expected values, or a default statement.

```swift
let monthNum = 3
switch monthNum {
case 1:
    print("January")
}
```

<details>
<summary><b>Solution</b></summary>

**c.** The code will not compile because switch statements need case statements for all expected values, or a default statement.

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

#### Exercise 5.
Create a switch statement that will convert a number grade into a letter grade as shown below:
* 100 -> A+
* 90 - 99 -> A
* 80 - 89 -> B
* 70 - 79 -> C
* 65 - 69 -> D
* Below 65 -> F

#### Exercise 6.
Consider the switch statement below. What is the output as written? What happens when you change _number_ to 365? 1024? 65? What happens when you remove the __default__ case?
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

#### Exercise 7.
Consider the variable below called _population_ and the if-condition.
1. Add an else-if-condition that states if _population_ is less than 10000 but greater than 5000, the message changes to say it's "a medium size town".
2.  Add an else-condition where the message changes to say it's a mid-size town.
3. Convert your final if-else statement to a switch statement.

```swift
var population: Int = 10000
var message = String()

if population > 10000 {
    message = "\(population) is a large town"
}
```

#### Exercise 8.
Complete the code below so that it prints out and tells the user if the sum of the two numbers in the tuple is at least 15.
a) Using a conditional
b) Using a switch statement

```swift
let myTuple: (Int, Int) = (5, 10)
```

#### Exercise 9.
Complete the switch statement below.  We want it to output a personalized greeting to the student based on their name and class.

```swift
let studentNameAndClass = ("Ben", 3.2)
switch myTupleTwo{
   
}

```

#### Exercise 10.
Consider the below switch with a tuple.
* Add a case for when _y_ is __double__ the value of _x_
* Add a case for when _y_ is __triple__ the value of _x_

```swift
switch (x,y) {
case let (x,y) where x == y:
    print("x is equal to y")
case let (x,y):
    print("Nothing is special about this tuple")
}
```

#### Exercise 11.
Write an `if` statement that checks to see what quadrant a point is in, then prints that quadrant.
Then write it as a `switch` statement.

```swift
let myPoint: (Double, Double)
```

#### Exercise 12.
Write an if statement that prints out what decade of life someone is in (e.g "You are in your twenties).
Then write it as a switch statement.
```swift
let nameAndBirthYear: (String, Int)
```

#### Exercise 13.
Write a switch statement that switches on a tuple with two Bools `(Bool, Bool)` and prints what logical operators `(&&, ||)` could be applied to make a true expression.
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
Next, write a switch statement that switches on a tuple with 3 Bools `(Bool, Bool, Bool)` and prints what logical operators `(&&, ||)` could connect all Bools with to make a true expression.
```swift
let pAndQAndR: (Bool, Bool, Bool)
```

#### Exercise 14.
Write a conditional statement that prints out whether a number is a whole number.

#### Exercise 15.
 You're walking in Manhattan. Streets go East-West and Avenues go North-South. Write a `switch` statement that switches on a String named "direction" having one of the values "North", "East", "West", or "South" and tells you if you're on a street or avenue.

 e.g. if `direction` has the value "West" you should print "street".
 
