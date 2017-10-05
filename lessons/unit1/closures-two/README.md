### Objective

* To understand and use closures as return types
* To understand capturing, or closing over variables
* Create functions that track internal information through closures
* Use map(:_) to solve problems
* Use filter(:_) to solve problems
* Re-implement filter and map to reinforce understanding of closures


### Readings
Swift Programming: The Big Nerd Ranch Guide, Chapter 13 Closures

Apple's [Swift Language Reference, Closures](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html#//apple_ref/doc/uid/TP40014097-CH11-ID94)

### Vocabulary
- **algorithm** - a process or set of rules to be followed in calculations or other problem- **block** - One or more lines of code, enclosed with curly braces. Sometimes used interchangeably with closure, especially in Objective-C.
- **closure** - An executable block of code. Like a function, it can take input parameters and return a value. A function is actually a special case of a closure.
-solving operations, especially by a computer.
- **higher-order function** - A function that takes a closure as one or more of its arguments and/or returns a closure. 
- **scope** - the visibility of a variable or other identifier based on where it is defined within the program.


### Review Exercises

### Use ```filter(_:)```

> Filter out strings containing "bad words".
> First split text on the space using ```componentsSeparatedByString(_:)```, 
> then use filter to cut out the words. Print out the expurgated version as a string.

```swift
let badWords = ["heck", "darn", "drat", "fudge"]
let text = "What the heck we s'posed to do you darn fool. Drat that cat. Oh fudge."
// output: What the we s'posed to do you fool. that cat. Oh.
```

### Use ```map(_:)```

> ```filter``` produced unnatural results. Let's start over.
> Again, split text on the space using ```componentsSeparatedByString(_:)```
> but this time use map to replace the words with red blooded American cuss-words
> (or whatever words you like) and print.


### Use ```reduce(_:)```
>Our map worked pretty well for us, but we've discovered a newfound hatred of vowels.  We can use reduce directly on our string ```badWords```.  Let's make a new string using reduce that takes out all the vowels.




### Closures as return types

In the first closures lesson we focused on the more common sense of higher order functions, passing in closures as arguments to functions, notably to `sort(by:)`. But a function that returns a closure is also described as being higher order. Let's step through the process of returning a closure from a function and then calling it.

Recall the general form of a closure.

```swift
{ (parameters) -> ReturnType in
    statements
}
```

And how we can store a closure in a variable and call it.

```swift
var doubler = { (a: Int) -> Int in
    return a * 2
}
print(doubler(22))
```

Now, combine the idea that a closure can be assigned to a variable with the idea that a function can return a closure. Here is the definition of a function that returns a closure.

```swift
func makeMultiplier(factor: Int) -> (Int) -> Int {
    return {(n) in factor * n}
}
```

And here we call the function and store the closure it returns in variables that are executable.

```swift
let timesTwo = makeMultiplier(factor: 2)
let timesFive = makeMultiplier(factor: 5)
print(timesTwo(53))
print(timesFive(3))
``` 


### Capture values
```swift
// close over "number" and define function
var number = 0
var addOne = {
    number += 1
}
addOne()
addOne()
print(number)
```

### Closures are reference types

The following illustration from Apple's documentation will serve to illustrate all
three of the following concepts.

* Functions as Return Types
* Closures Capture Values
* Closures are Reference Types
* Escaping


### Examples of returning closures

First of all, `incrementer` is a function that we'll return and when we assign
a constant to it and call it it will update the  `runningTotal` variable
that it captured from its enclosing function. By instantiating new copies of the function
as well as assigning new references to exising ones we can illustrate how closures
are reference types. See comments.

```swift
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

// inc is an instance of the incrementer function
let inc = makeIncrementer(forIncrement: 1)

// calling it repeatedly will increment runningTotal
inc()                   // runningTotal = 1
inc()                   // runningTotal = 2
let inc2 = inc
inc2()                  // runningTotal = 3

// new instance starts again
let inc3 = makeIncrementer(forIncrement: 10)
inc3()                  // runningTotal = 10
let inc4 = inc3
inc4()                  // runningTotal = 20
```

Each unique instance of the function has its own captured ```runningTotal``` which
is incremented on each call, but additional references to the same function share
the same memory and so increment the same instance. 

## Returning Functions

```swift
func doublerFactory(funk: (Int)->Int) -> (Int) -> Int {
    let f = {(a: Int) -> Int in
        return 2 * funk(a)
    }
    return f
}


let f = doublerFactory { (x: Int) -> Int in
    return x * x
}

f(3)
```

**Question:** What's the motive for returning functions, and for higher order functions in general?

<details>
<summary>Solution</summary>Flexibility. One way or another these techniques offer flexibility, either allowing for the
deferment of running code or for more dynamic code. 
</details>


An example in practice:

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

# Review and Wrapup

* What are higher order functions?
* Why pass functions?
