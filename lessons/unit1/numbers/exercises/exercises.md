### Numbers Exercises

---

#### Question 1.
What is true about __Integers__ in computers?
```swift
a. Integers must have a positive or negative sign always.
b. The maximum value for Integers is +∞.
c. Integer types in computers take up a fixed amount of memory.
d. Integers may contain decimals.
```

<details>
<summary><b>Solution</b></summary>

```
C. Integer types in computers take up a fixed amount of memory.
```

</details>


#### Question 2.
Explain why the maximum value of ```UInt8``` is equals 255. Why is the maximum value of ```Int8``` 127?

<details>
<summary><b>Solution</b></summary>

```
8-bits allows for 255 numbers. Int8 has a max value of only 127 because half of the memmory is used for negative numbers whereas UInt8 has all spaces available for positive numbers. The relationship between the min and max numbers of signed and unsigned numbers is: UInt8.max = Int8.max + |Int8.min|
```

</details>

#### Question 3.
Consider the constants below. Which code will compile?
```swift
a. let numberOfPages: Int = 500
b. let numberOfChapters = "For Whom The Bell Tolls"
c. let nameOfBook: Int = 14
d. let yearPublished = "Nineteen-thirty-five"
e. All will compile.
```

<details>
<summary><b>Solution</b></summary>

```
E. All will compile.
```

</details>

#### Question 4.
Given:
```swift
var a = 20
var b = 5
var c = 4
```
Compute:
```swift
a += b
b -= c
b * (c + a)
(b * c) + a
b %= a
b %= c
```

<details>
<summary><b>Solution</b></summary>

```swift
a += b // 25
b -= c // 1
b * (c + a) // 29
(b * c) + a // 29
b %= a // 1
b %= c // 1
```

</details>


#### Question 5.
What are the values of ```div``` and ```div2``` below? Are they equal?
```swift
let div = 11 / 3
let div2 = 11.0 / 3.0
```

<details>
<summary><b>Solution</b></summary>

```swift
let div = 11 / 3 // Evaluates to 3, Type: Int
let div2 = 11.0 / 3.0 // Evaluates to 3.66666666666667, Type: Double

div != div2 // true
```

</details>


#### Question 6.
Given ```var number = 7.5```. What can be inferred about `number`?
```swift
a. number is a float variable
b. number is a double variable
c. number is a 32-bit floating point number
d. not enough information to infer about number's type
```

<details>
<summary><b>Solution</b></summary>

```
D. Not enough information to infer about number's type
```

</details>


#### Question 7.
Without using Playground, will the below code print?
```swift
let twelve: Double = 12.0
let thirteen: Float = 13.0

print(twelve + thirteen)
```


<details>
<summary><b>Solution</b></summary>

```
No, because Swift will not compare, or combine, values of different types. Although the Float and Double types are used to represent decimal numbers, they are still different types. In order to compare, or combine, we would have to cast the float as a double (or the double as a float) so that we are working with the same type on both sides of the expression.
```

</details>


#### Question 8.
Write the following numbers in binary representation:
```swift
a. 25
b. 100
c. 65
d. 255
```

<details>
<summary><b>Solution</b></summary>

```
a. 25 = 00011001 
b. 100 = 01100100 
c. 65 = 01000001 
d. 255= 11111111
```

</details>


#### Question 9.
Convert the if/else statement below into a switch statement.

```swift
if temperatureInFahrenheit <= 40 {
  print("It's cold out.")
} else if temperatureInFahrenheit >= 85 {
  print("It's really warm.")
} else {
  print("Weather is moderate.")
}
```
<details>
<summary><b>Solution</b></summary>

```swift
switch temperatureInFahrenheit {
case temperatureInFahrenheit where temperatureInFahrenheit <= 40:
     print("It's cold out.")
case temperatureInFahrenheit where temperatureInFahrenheit >= 85:
    print("It's really warm.")
default:
    print("Weather is moderate.")
}
```

</details>


#### Question 10.
Consider the variable below called `population` and the if-condition.

 * Add an else-if-condition that states if `population` is less than 10000 but greater than 5000, the message changes to say it's "a medium size town".
 * Add an else-condition where the message changes to say it's a small size town.
 * Convert your final if-else statement to a switch statement.

```swift
var population: Int = 10000
var message = String()

if population > 10000 {
  message = "\(population) is a large town"
}
```
<details>
<summary><b>Solution</b></summary>

```swift
if population >= 10000 {
    message = "\(population) is a large town"
} else if population < 10000 && population > 5000 {
    message = "\(population) is a medium size town"
} else {
    message = "It's a small town."
}

switch population {
case population where population >= 10000:
    message = "\(population) is a large town"
case population where population < 10000 && population > 5000:
    message = "\(population) is a medium size town"
default:
    message = "It's a small town."
}
```

</details>


#### Question 11.
Consider the below switch with a tuple.

 * Add a case for when _y_ is __double__ the value of _x_
 * Add a case for when _y_ is __triple__ the value of _x_

```swift
switch (x,y) {
case let (x,y) where x==y :
  print("x is equal to y")
case let (x,y):
  print("Nothing is special about this tuple")
}
```
<details>
<summary><b>Solution</b></summary>

```swift
switch (x,y) {
case let (x,y) where x == y :
    print("x is equal to y")
case let (x,y) where y == x * 2:
    print("y is equal to x doubled")
case let (x,y) where y == x * 3:
    print("y is equal to x tripled")
case let (x,y):
    print("Nothing is special about this tuple")
}

```

</details>


#### Question 12.
Consider the below switch statement.

 12a. What should your system currently print?
 12b. What happens when you change _number_ to a. 365? b. 1024? c. 65?
 12c. What happens when you remove the __default__ clause?

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
<summary><b>Solution</b></summary>

```
12a. "The answer to life, the universe and everything"
12b. "Days in year"; "Bytes in Kilobyte"; "Some uninteresting number"
12c. The code will no longer compile because switch statements need to be exhaustive in that they account for every possible value of number. 
```

</details>


#### Question 8.
Which of the following numbers can't be assigned to an Int8, and why?:
```swift
a. 25
b. 100
c. 65
d. 255
```

<details>
<summary><b>Solution</b></summary>

```
D. 255
255 cannot be assigned to Int8 because the maximum possible value for Int8 is only 127. 
```

</details>


#### Question 9.

What integer types could you use for the offending value in Question 8 that would not produce an error?


<details>
<summary><b>Solution</b></summary>

```
All of the variations of UInt can be used (UInt8, UInt16, UInt32, UInt64, UInt), as well as every variation of Int EXCEPT FOR Int8 (Int16, Int34, Int64, Int). 
```

</details>

#### Question 10.

What are the differences between ```Double``` and ```Int``` in the numbers they can represent and how they store them?


<details>
<summary><b>Solution</b></summary>

```
Ints are used to store whole numbers. Doubles, on the other hand, represent decimals.
```

</details>


#### Question 11.

What are the differences between ```Float``` and ```Double```?


<details>
<summary><b>Solution</b></summary>

```
A Double is more precise than a float. A Double also has more memory to store more decimals.
```

</details>

#### Question 12.

What will the following code do?:

```swift
var width: Double = 48.8
var extraWidth: Float = 10.5

let totalWidth = width + extraWidth
```
<details>
<summary><b>Solution</b></summary>

```
The code will generate a compiler error because a Float and a Double cannot be combined without explicit conversion.
```

</details>

#### Question 13.

Alter the code in Question 12 to do what we want it to.

<details>
<summary><b>Solution</b></summary>

```swift
var width: Double = 48.8
var extraWidth: Float = 10.5

let totalWidth = width + Double(extraWidth)
```

</details>