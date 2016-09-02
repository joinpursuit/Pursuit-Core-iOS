# Standards
Use functions to solve problems

# Objectives
* Create functions that track internal information through closures
* Use map(:_) to solve problems
* Use filter(:_) to solve problems
* Re-implement filter and map to reinforce understanding of closures

Vocabulary: closure, block, algorithm, sort, maintenance, scope, higher-order

# Resources
Swift Programming: The Big Nerd Ranch Guide, Chapter 13 Closures

Apple's [Swift Language Reference, Closures](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html#//apple_ref/doc/uid/TP40014097-CH11-ID94)

# Lecture

## Warm up

Let's see some solutions to the microwave problem (exercise 10 from yesterday). We'll vote on one
to use.

## Advanced Topics with Closures

The following illustration from Apple's documentation will serve to illustrate all
three of the following concepts.

* Functions as Return Types
* Closures Capture Values
* Closures are Reference Types

First of all, ```incrementer``` is a function that we'll return and when we assign
a constant to it and call it it will update the  ```runningTotal``` variable
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

Solution to tricksy, tricksy exercise from yesterday:

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

> **Q.** What's the motive for returning functions, and for higher order functions in general?

A. Flexibility. One way or another these techniques offer flexibility, either allowing for the
deferment of running code or for more dynamic code. 

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
**Exercises** 

1. Add a squaring operator.
2. Add a power operator.
3. Add an integer division operator.

## Map and Filter

### Map
Map is used to perform the same code on an entire array, and returns a new array.

```swift
let someInts = [1, 2, 3]
someInts.map { (a) -> Int in
    return a * 2
}
```

It can return an element type different from that of the input array.

```swift
someInts.map { (a) -> String in
    return String(a)
}
```
### Filter

Filter's closure parameter takes an element of the array and returns a Bool that
determines whether that value is to be included in the ouput array.

```swift
someInts.filter { (a) -> Bool in
    return a % 2 == 1
}
```

### Exercises

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


### Re-implement ```filter(_:)```. 

> Since you can't add your new filter method to the
> Array class (yet) just let it take the input array as a first parameter.

### Re-implement ```map(_:)```

> Re-implement ```map(_:)``` the same way. In addition to the limitations placed on the
> re-implementation of ```filter(_:)```, also limit the mapping so that it can only map values
> of the same type as the input array. E.g. an ```[Int]``` can only create an ```[Int]``` as its
> final output, which also affects how the closure will be defined. The ```map(_:)``` method
> on Array has no such limitation.

# Review and Wrapup

* What are higher order functions?
* Why pass functions?
