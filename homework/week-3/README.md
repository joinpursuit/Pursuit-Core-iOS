## Week 3 Homework


> Exhibit A. (mathStuffFactory)

```swift
func mathStuffFactory(opString: String) -> (Double, Double) -> Double {
    switch opString {
    case "+":
        return {x, y in x + y }
    case "-":
        return {x, y in x - y }
    case "*":
        return {x, y in x * y }
    case "/":
        return {x, y in x / y }
    default:
        return {x, y in x + y }
    }
}
```

#### Q1a. Command Line Math Stuff
Incorporate ```mathStuffFactory(_:)``` that we worked on in Closures Two into
a  command line application. Parse input from the user into operator, and two operands,
run the operation and return the answer.  Reject non-conforming ops with a message.

For example, your console might look like this:

```
>>> 5 + 3
5 + 3 = 8
>>> 5 * 3
5 * 3 = 15
>>> 5 & 3
Unknown operator: &
>>> Exit
```

#### Q1b. Mix in an Enumeration

Rework to include an ```enum``` to represent the operator cases.

#### Q1c. Random Math Stuff

Make question mark perform a random operation.

#### Q1d. Random Math Stuff Game

When the question mark operator is used the application will secretly perform
the operation and return only the result. The user is then prompted to guess the
operator used.

For this, your console might look like this:

```
>>> 5 + 3
5 + 3 = 8
>>> 5 ? 3
15
>>> -
Nope!
>>> *
Correct!
>>> Exit
```

#### Q2. Implement your **own** filter function

> **Note**: Questions 2 and 3 should also be implemented inside a variation of the command
> loop we built in class, and which you used to work on Question 1. This way you can put
> the whole assignment in one swift file. To hook this up, you should create functions just like we did for
> ```echo``` and ```number``` in class. From those functions you can call
> your implementations of ```myFilter``` and ```myMap```.
> You will have to look out for ```map``` and ```filter``` commands and treat them
> separately to the operations handled by your solution to Question 1.

Write your own filter function, ```myFilter(_:filter:)```. You'll only
be able to write it to work for one type at this point. Let's make it work
for an array of ```Int```.

```swift
let ints = [4,2,6,3,4,6,2,8,5]

// the built-in function works like this
let filtered = ints.filter { (a) -> Bool in
    a % 2 == 0
}

// ... but your function will have to take the array as its first parameter
// and the closure as the second/last parameter.
myFilter(ints) { (a) -> Bool in
    a % 2 == 0
}
```

Use this as a starting point.

```swift
func myFilter(inputArray: [Int], filter: (Int) -> Bool) -> [Int] {

}
```

#### Q3. Implement your **own** map function

Follow the same approach as you used to solve Q2 to write your own map function.


#### Don't forget to read Classes and Structs.

