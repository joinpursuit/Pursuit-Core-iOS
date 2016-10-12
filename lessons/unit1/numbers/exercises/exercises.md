## Numbers

#### Question 1.
What is true about __Integers__ in computers?
```
a. Integers must have a positive or negative sign always.
b. The maximum value for Integers is +∞.
c. Integer types in computers take up a fixed amount of memory.
d. Integers may contain decimals.
```

#### Question 2.
Explain why the maximum value of ```UInt8``` is equals 255. Why is the maximum value of ```Int8``` 127?

#### Question 3.
Consider the constants below. Which code will compile?
```
a. let numberOfPages: Int = 500
b. let numberOfChapters = "For Whom The Bell Tolls"
c. let nameOfBook: Int = 14
d. let yearPublished = "Nineteen-thirty-five"
e. All will compile.
```

#### Question 4.
Evaluate the following:
Given:
```
var a = 20
var b = 5
var c = 4
```
Compute:
```
1. a += b
2. b -= c
3. b * (c + a)
4. (b * c) + a
5. b %= a
6. b %= c
```

#### Question 5.
What are the values of ```div``` and ```div2``` below? Are they equal?
```
let div = 11 / 3
let div2 = 11.0 / 3.0
```

#### Question 6.
Given ```var number = 7.5```. What can be inferred about __number__?
```
a. number is a float variable
b. number is a double variable
c. number is a 32-bit floating point number
d. not enough information to infer about number's type
```

#### Question 7.
Without using Playground, will the below code print?
```
let twelve: Double = 12.0
let thirteen: Float = 13.0

print(twelve + thirteen)
```

#### Question 8.
Write the following numbers in binary representation:
```
a. 25
b. 100
c. 65
d. 255
```
<<<<<<< HEAD
### Question 9.
Convert the if/else statement below into a switch statement.

```
if temperatureInFahrenheit <= 40 {
  print("It's cold out.")
} else if temperatureInFahrenheit >= 85 {
  print("It's really warm.")
} else {
  print("Weather is moderate.")
}
```

### Question 10.
Consider the variable below called _population_ and the if-condition.
* Add an else-if-condition that states if _population_ is less than 10000 but greater than 5000, the message changes to say it's "a medium size town".
* Add an else-condition where the message changes to say it's a small size town.
* Convert your final if-else statement to a switch statement.

```
var population: Int = 10000
var message = String()

if population > 10000 {
  message = "\(population) is a large town"
}
```

### Question 11.
Consider the below switch with a tuple.
* Add a case for when _y_ is __double__ the value of _x_
* Add a case for when _y_ is __triple__ the value of _x_

```
switch (x,y) {
case let (x,y) where x==y :
  print("x is equal to y")
case let (x,y):
  print("Nothing is special about this tuple")
}
```
### Question 12.
Consider the below switch statement.
* What should your system currently print?
* What happens when you change _number_ to a. 365? b. 1024? c. 65?
* What happens when you remove the __default__ clause?

```
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
=======

#### Question 8.
Which of the following numbers can't be assigned to an Int8, and why?:
```
a. 25
b. 100
c. 65
d. 255
```

#### Question 9.

What integer types could you use for the offending value in Question 8 that would not produce an error?:

#### Question 10.

What are the differences between ```Double``` and ```Int``` in the numbers they can represent and how they store them?

#### Question 11.

What are the differences between ```Float``` and ```Double```?

#### Question 12.

What will the following code do?:

```swift
var width: Double = 48.8
var extraWidth: Float = 10.5

let totalWidth = width + extraWidth
```

#### Question 13.

Alter the code in Question 12 to do what we want it to.
>>>>>>> upstream/master
