### Objective

* To understand the purpose of using closures
* To recognize the how a function is a type of closure
* To understand closure syntax
* To solve problems by using functions that take a closure as an argument

### Vocabulary

- **algorithm** - a process or set of rules to be followed in calculations or other problem- **block** - One or more lines of code, enclosed with curly braces. Sometimes used interchangeably with closure, especially in Objective-C.
- **closure** - An executable block of code. Like a function, it can take input parameters and return a value. A function is actually a special case of a closure.
-solving operations, especially by a computer.
- **higher-order function** - A function that takes a closure as one or more of its arguments and/or returns a closure. 
- **lambda** - A more general computer science term synonymous with closure.
- **sort** - Reorder a list of data, usually an Array in Swift.

### Readings

1. Swift Programming: The Big Nerd Ranch Guide, Chapter 13 Closures
1. Apple's [Swift Language Reference, Closures](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html#//apple_ref/doc/uid/TP40014097-CH11-ID94)

### Closures

Closures are self-contained blocks of functionality that can be passed around and used in your code. Closures can capture and store references to any constants and variables from the context in which they are defined. This is known as closing over those constants and variables. 

Functions are actually special cases of closures. 

Functions and closures are first class citizens. They are "things" that can be passed as functions and returned from functions like any other type.

Closures take one of three forms:

- Global functions are closures that have a name and do not capture any values.
- Nested functions are closures that have a name and can capture values from their enclosing function.
- Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.

Swift’s closure expressions have a clean, clear style, with optimizations that encourage brief, clutter-free syntax in common scenarios. These optimizations include:

- Inferring parameter and return value types from context
- Implicit returns from single-expression closures
- Shorthand argument names
- Trailing closure syntax

> Adapted from [The Swift Programming Language - Apple](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html#//apple_ref/doc/uid/TP40014097-CH11-ID94)

### Why closures?

Closures allow us to write anonymous blocks of functionality that may only be used once or in a limited context. This is the advantage of their anonymity. A closure is not named as a function is because, being used in just one place, it don't need to be referred to. In this sense it's like a literal.

The benefit of using higher order functions, that is functions that take or return closures as arguments or return types is separate from the anonymity of closures. Higher order functions allow the programmer to inject a piece of original functionality into an existing function, in the case of functions that take closures as parameters. We'll explore this in depth with `sorted(by:)`. Less common are functions that return closures. We'll look at some more contrived examples of these.

### Closure syntax

This is the general form of a closure:

```swift
{ (parameters) -> ReturnType in
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

Note how Swift is inferring the type of `add` from the closure just as it would for any type or literal. That type is `(Int, Int) -> Int`, read, "a closure of Int, Int returning Int".

If the type is annotated in the constant or variable the inference can happen on the right hand of the assignment.

```swift
let add: (Int, Int) -> Int = { (a, b) in
    return a + b
}
add(4, 9)
```

Here, since the signature of the closure is annotated explicitly, the definition of the closure can drop the types of the arguments and the return type.

### Closures as function parameters

Both the Big Nerd Ranch book and Apple's documentation use Array's `sorted(by:)` method to introduce closures passed to a function, and to illustrate various shorthand syntaxes used when working with closures. All the calls to `sorted(by:)` in the code below do the same exact thing, except for the first call that uses `backward(_:_:)` which is still functionally equivalent.

```swift
// 1. The unsorted array
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

// 2. A function that takes two String arguments, returning a Bool
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

// 3. Call `sorted(by:)` passing the `backward(_:_:)` function we defined
var reversedNames = names.sorted(by: backward)

// 4. Function converted to closure
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})

// 5. function on one line
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )

// 6. Argument types are implied by sorted(by:)'s definition
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )

// 7. if  one line, "return" is inferred
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )

// 8. shorthand argument names
reversedNames = names.sorted(by: { $0 > $1 } )

// 9. operator method, >
reversedNames = names.sorted(by: >)

// 10. trailing closure syntax
reversedNames = names.sorted() { $0 > $1 }

// 11. trailing closure syntax omitting the parentheses (function operator)
reversedNames = names.sorted { $0 > $1 }
```

1. An array of String, `[String]`.
2. A function signifying whether s1 should be sorted before s2.
3. Call `sorted(by:)`, passing our function.
4. Convert `backward` to closure form. We don't need it anymore.
5. Just move the same exact closure onto one line.
6. The `by` parameter of `sorted(by:)` knows its type `(String, String) -> Bool` so a call to the function that defines a closure can infer the type of its arguments.
7. If the body of your closure is one line and evaluates to the return type the `return` itself can be omitted. The one line is `s1 > s2`.
8. We can refer to arguments by numbered shorthand names so they don't need to be declared. This function takes two parameters. They can be found in $0 and $1.
9. Operator methods. Since `String` overloads the `>` operator which works just like any function, Swift sees that its type, `>(_:String, _:String) -> Bool` matches what sort expects, just as our `backward(_:_:)` had.
10. Trailing closure syntax. When the last argument in a function is a closure, you have the option to define it outside the parentheses. This is more apparently useful when the closure has more than one line.
11. Building on the previous syntax, when a closure is the only argument to a function (which is a special case of being the last argument), the parentheses can be omitted.

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

