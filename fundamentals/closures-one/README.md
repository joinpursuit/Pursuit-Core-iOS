### Objective

* To understand the purpose of using closures
* To recognize the how a function is a type of closure
* To understand closure syntax
* To solve problems by using functions that take a closure as an argument

### Vocabulary

- **algorithm** - a process or set of rules to be followed in calculations or other problem
- **block** - One or more lines of code, enclosed with curly braces. Sometimes used interchangeably with closure, especially in Objective-C.
- **closure** - An executable block of code. Like a function, it can take input parameters and return a value. A function is actually a special case of a closure.
-solving operations, especially by a computer.
- **higher-order function** - A function that takes a closure as one or more of its arguments and/or returns a closure.
- **lambda** - A more general computer science term synonymous with closure.
- **sort** - Reorder a list of data, usually an Array in Swift.

### Readings

1. [Apple Swift Language Reference - Closures](https://docs.swift.org/swift-book/LanguageGuide/Closures.html)
2. [Gosh Darn Closure Syntax](http://goshdarnclosuresyntax.com/)

### Closures

Closures are self-contained blocks of functionality that can be passed around and used in your code.  If this definition seems familiar, it's because it sounds very similar to functions.  So what's the difference between closures and functions?  Turns out we've been using closures all along.  A function is actually a special type of closure.  A closure is like a function that is treated exactly the same as any other type.  Closures can be stored in variables, passed as arguments into functions exactly like you could with a String or Array.


### Why closures?

We can use closures to give functions more information about how to do something.  For example, arrays have a method `sorted(by:)`.  We can use closures to give instructions to the `sorted(by:)` method, telling it to sort ascending or descending.  We'll look more into how to tell it that this lesson.

Another advantage of closures is that they are *anonymous*.  This means that we can create one without a name.  Functions need names, but closures are created without one.  We can save a closure to a variable if we want to use it later.  This is useful, because we may only need to define a specific set of functionality once.  It will end up saving us some time, and is easier for other people to read.

### Closure syntax

This is the general form of a closure:

```swift
{ (parameterOne: Type, parameterTwo: Type) -> ReturnType in
  //Closure body goes here...
}
```

It reads very much like a function definition but it's not exactly the same. Most obvious is the missing name, which is why they can be called anonymous functions. Also the opening brace and signature are reversed. Lastly, related to that reversal, the keyword `in` appears after the signature to mark the end of the signature and the beginning of executable code.

### Closures as constants and variables

A closure can be stored in a constant or variable:

```swift
// assignment of a closure to the add constant
let add = { (a: Int, b: Int) -> Int in
    return a + b
}

// add is of type (Int, Int) -> Int
// it is executable and can be called just like a function
add(4, 9)
```

Note how Swift is inferring the type of `add` from the closure just as it would for any type or literal. That type is `(Int, Int) -> Int`, which can be read as, "a closure of Int, Int returning Int".

If the type is annotated in the constant or variable the inference can happen on the right hand of the assignment.

```swift
let add: (Int, Int) -> Int = { (a, b) in
    return a + b
}
add(4, 9)
```

Here, since the signature of the closure is annotated explicitly, the definition of the closure can drop the types of the arguments and the return type.

**Exercise: Make a closure for subtraction, multiplication and division**

<details>
<summary>Solutions</summary>

```
let subtract = {(a: Int, b: Int) -> Int in
    return a - b
}
let divide = {(a: Int, b: Int) -> Int in
    return a / b
}
let multiply = {(a: Int, b: Int) -> Int in
    return a * b
}
```

</details>


Closures are "First-class citizens" which means that they behave just like any other type.

let operations: [(Int, Int) -> Int] = [add, subtract, multiply, divide]

func combine(_ x: Int, and y: Int, with operation: (Int, Int) -> Int) -> Int {
    return operation(x, y)
}

**Exercise: Combine 8 and 3 with modulo using the combine function**

<details>
<summary>Solution</summary>

```swift
combine(8, and: 3, with: {(a: Int, b: Int) -> Int in
    let mod = a % b
    return mod
})
```

</details>


### Closures as function parameters

As we saw in the example above, we can use closures as parameters in a function.  Closures also have a special shorthand syntax that we can use to reduce the amount of code we need to write.  The following examples go through several different ways to achieve the same result.

Let's look deeper at the `sorted(by:)` method.  The full function for sorted an array of Strings looks something like this:

```swift
func sorted(by areInIncreasingOrder: (String, String) -> Bool) -> [String]
```

We need to give it closure that "returns true if its first argument should be ordered before its second argument; otherwise, false".  Put another way, the closure takes in two Strings and returns whether or not they are already sorted.

If we wanted to be very verbose, we could declare a function.

```swift
func backward(_ s1: String, _ s2: String) -> Bool {
  return s1 > s2
}

Then, we can use the function as the argument that `sorted(by:)` is expecting:

```swift
var reversedNames = unsortedNames.sorted(by: backward)
```

What this means is that when it looks at two name (e.g "Chris" and "Alex") our closure returns true, which means that "Chris" should come before "Alex".  The method will run to ensure that every element is ordered according to our closure.

The above would work fine, but it's a little annoying to have to write out a whole function that we only used one.  Anonymous closure syntax allows us to get around that issue:

```swift
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
```

Now we don't need to write a whole function to do something one time.  This works too, but we can actually use some shorthand syntax to make this easier to read.  The following examples all do exactly the same thing as the example above:

```

// function on one line
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )

// The by parameter of sorted(by:) knows its type (String, String) -> Bool
// A call to the function that defines a closure can infer the type of its arguments.
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )

// If  one line, "return" is inferred
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )

// We can refer to arguments by numbered shorthand names so they don't need to be declared.
// This function takes two parameters. They can be found in $0 and $1
reversedNames = names.sorted(by: { $0 > $1 } )

// String overloads the > operator which works just like any function,
// Swift sees that its type, `>(_:String, _:String) -> Bool` matches what sort expects.
reversedNames = names.sorted(by: >)

// Trailing closure syntax
// When the last argument in a function is a closure, you have the option to define it outside the parentheses
reversedNames = names.sorted() { $0 > $1 }

// Trailing closure syntax omitting the parentheses
// When a closure is the only argument to a function, the parentheses can be omitted as well
reversedNames = names.sorted { $0 > $1 }
```

### Exercise

Let's practice by making calls to `sorted(by:)` with closures to accomplish different orders. In defining the closure think both about the strategy required (to return whether the first argument is less than the second), and reflect on how this extracted bit of functionality is enough to influence the behavior of the `sorted(by:)` function.

Given

```swift
let numbers = [32, 21, 33, 2, 66, 88, 43, 902, 73, 27, 905]
let words = ["One", "two", "Buckle", "my", "shoe"]
```

1. Sort `numbers` ascending.
1. Sort `words`, descending case-insensitive.
1. Sort `words` by the length of each element.
1. Sort `numbers` ascending, even numbers first, odd numbers second. Output will be [2, 32, 66, 88, 902, 21, 27, 33, 43, 73, 905].

### Map, Filter and Reduce

#### Map

Array's `map(_:)` is used to execute a closure on each element, creating a new corresponding element in an new array.

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
determines whether that value is to be included in the output array.

```swift
someInts.filter { (a) -> Bool in
    return a % 2 == 1
}
```

### Reduce

The reduce method solves the problem of combining the elements of an array to a single value.

```swift
let numbers = [1, 2, 3, 4]
let numberSum = numbers.reduce(0, { x, y in
    x + y
})
// numberSum == 10
```


### Capture lists

(Adapted from [Bob the Developer](https://www.bobthedeveloper.io/blog/swift-capture-list-in-closures))

Just like functions closures are able to refer to global variables.  This can occasionally create some challenges:

```swift
var printingClosures: [() -> Void] = []

var i = 0

for _ in 0..<3 {
    let newClosure = { print("I know how to print \(i)") }
    printingClosures.append(newClosure)
    i += 1
}

for printingClosure in printingClosures {
    printingClosure()
}
```

We would like the code block above to print:

```
I know how to print 1
I know how to print 2
I know how to print 3
```

But instead it prints:

```
I know how to print 4
I know how to print 4
I know how to print 4
```

What's going on?  Each of the different closures we make has "closed over" the variable `i`.  Each closure is referring to the same variable, so the closure doesn't print the value of `i` when it was made, but whenever it happens to be called.  What we want to do is **capture** the value of `i` as soon as we make our closure and save a snapshot of that value.  We can do this using the syntax below:

```swift
var printingClosures: [() -> Void] = []

var i = 0

for _ in 0..<3 {
    let newClosure = {[i] in print("I know how to print \(i)") }
    printingClosures.append(newClosure)
    i += 1
}

for printingClosure in printingClosures {
    printingClosure()
}
```

### Exercises

### Use `filter(_:)`

> Filter out strings containing "bad words".
> First split text on the space using `componentsSeparatedByString(_:)`,
> then use filter to cut out the words. Print out the expurgated version as a string.

```swift
let badWords = ["heck", "darn", "drat", "fudge"]
let text = "What the heck we s'posed to do you darn fool. Drat that cat. Oh fudge."
// output: What the we s'posed to do you fool. that cat. Oh.
```

### Use `map(_:)`

> `filter` produced unnatural results. Let's start over.
> Again, split text on the space using `componentsSeparatedByString(_:)`
> but this time use map to replace the words with the appropriate number of `*`s.


### Use `reduce(_:)`
>Our map worked pretty well for us, but we've discovered a newfound hatred of vowels.  We can use reduce directly on our string `badWords`.  Let's make a new string using reduce that takes out all the vowels.


### Standards

IOS: IOS.1

Language Fundamentals: LF.6

Engineering Foundations: EF.1
