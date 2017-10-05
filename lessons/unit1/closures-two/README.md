### Objective

* To understand and use closures as return types
* To understand capturing, or closing over variables
* Create functions that track internal information through closures


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

In the first closures lesson we focused on the more common sense of higher order functions, passing in closures as arguments to functions, notably to `sort(by:)`, `map(_:)`, and `filter(_:)`. But a function that returns a closure is also described as being higher order. Let's step through the process of returning a closure from a function and then calling it.

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

Now, let's make a function that returns a the same closure.

```swift
func makeDoubler() -> (Int) -> Int {
    return { (n: Int) -> Int in
        return n * 2
    }
}

// 1. capture the closure into a variable
let doublersDouble = makeDoubler()

// 2. run the closure
doublersDouble(5) // has the value of 10

// 3. even this syntax is possible
makeDoubler()(4)  // has the value of 8
```

1. We call the function `makeDoubler()` which itself returns a closure. 
2. A closure is captured in `doublersDouble` and is executable, so we call it.
3. We don't need to capture the result. Since `makeDoubler()` evaluates to a callable closure we can call it with `()`.

The `makeDoubler()` example is designed to be very simple. Let's write a function `makeMultiplier(factor:)` that is more complex and dynamic. We will pass it the number to muliply by. But, as with `makeDoubler()` it will not multiply directly. Instead, it will return a function that multiplies by the value passed in, named `factor`. The returned function will have the factor baked into it. Also, like `makeDoubler()` we'll need to pass the second operand to the functions `makeMultiplier(factor:)` returns.

> Note: I'm using function and closure interchangeably here. I could have just as easily said the functions returned closures. But it feels a little more natural to speak of functions when the closure has a name by which it is called.


```swift
func makeMultiplier(factor: Int) -> (Int) -> Int {
    return { (n) in
        return factor * n
    }
}

let doublerFromAnotherFunction = makeMultiplier(factor: 2) // 1. Make a "times 2" function
let fiveTimes = makeMultiplier(factor: 5) // 2. Make a "times 5" function
doublerFromAnotherFunction(12) // 3. Call the "times 2" function - returns 24
fiveTimes(3) // 4.  Call the "times 5" function - returns 15
fiveTimes(6) // 5.  Call the "times 5" function - returns 30
```

1. We call `makeMultiplier(factor:)` with an argument of 2 and it returns a function that will multiply _its_ argument by 2.
2. Same as the previous, except the returned function will multiply by 5.
3. Call `doublerFromAnotherFunction(_:)`, passing 12 to complete the mathematical calculation 2 * 12. The "2 *" part is baked into `doublerFromAnotherFunction(_:)` and the 12 is passed during the call.
4. And same for `fiveTimes(_:)`. Here we're using it to calulate 5 * 3.
5. We can call `fiveTimes(_:)` as many times as we like, passing a new value to multiply by each time.



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


