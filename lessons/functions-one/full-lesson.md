# Standards
* Master the use of functions

# Objectives
Students will be able to:
* Define and call functions
* Understand the components of a function signature

### Vocabulary: function, argument, parameter, input, output, define, call

# Resources
Swift Programming: The Big Nerd Ranch Guide, Chapter 12, Functions

Apple's [Swift Language Reference, Functions](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Functions.html#//apple_ref/doc/uid/TP40014097-CH10-ID158)

# Lecture
## Warm up

## Basic Function Syntax

```swift
func helloWorld() {
	print("Hello world")
}
```

## Parameters
```swift
func helloName(name: String) {
	print("Hello \(name)")
}
```

### Parameter names
```swift
// no external name for parameter #1
func helloName(name: String, withMessage message: String) {
	print("\(name) message")
}

// internal and external parameter names
func sayHello(numTimes count: Int, message: String) {
	for i in 1...numTimes {
		print(message)
	}
}

func sayHello(toMyLittleFriend friend: String) {
    print("Hello \(friend)")
}

sayHello(toMyLittleFriend: "Al")
```

### NYT

How would you use an external name to make this function more legible?

```swift
func randomInt(min: Int, max: Int) -> Int {
    if max < min { return min }
    return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
}
```

Remember ```String.init(count:repeatedValue:)```?

```swift
var str = String(count: 5, repeatedValue: Character("d"))
```

## Default parameter values
```swift
func helloName(name: String, withMessage: String = "Hi there!") {
	print("Hello world")
}
```
## Returning from a Function

```swift
func percent(num: Double) -> Double {
// write body
}

```
### NYT

Write a function that returns a string representation of the percentage, e.g. "45.3%

# Can return an Optional

# Review and Wrapup

* Define function.
* What's the difference between a function definition and a function call?
* Define parameter.
* What's the difference between a parameter and an argument?
* What's the purpose of a function's internal parameter names?
* Its external parameter names?
