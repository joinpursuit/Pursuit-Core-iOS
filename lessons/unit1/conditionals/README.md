# Conditionals

### Objective

* To understand and use `if / then / else` constructs
* To apply boolean logic to conditionals 

### Reading

1. Swift Programming: The Big Nerd Ranch Guide, Chapter 3, Conditionals
1. [Swift Language Reference, Control Flow - Apple](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ControlFlow.html#//apple_ref/doc/uid/TP40014097-CH9-ID120) Seek to **Conditional Statements**

#### Further Reading
1. [Conditionals - Wiki](https://en.wikipedia.org/wiki/Conditional_(computer_programming))
	- The diagrams at the top of the page are probably the most valuable part of this page.

#### Vocabulary
- **Branch** - A path of execution in a program.

---

### Introduction

Conditionals are what makes a program dynamic. Without them programs would have no way to do anything differently. We use the expression "branch" to refer to a possible path our program can take.  The analogy allows us to visualize the collection of all branches as a tree of sorts. The code enters at the trunk and as it executes will conditionally enter branches. We might imagine the branches getting thinner as a representation of the likliness that the branch will be reached. 

Note: there are a few places where we use the analogy of trees and branching in Computer Science. In this case branching refers to the path of execution through a program.

#### Exercise (Logic Review)

Given

```swift
let primate = "Ape"
let equid = "Zebra"
let cold = 32
let ideal = 75
let hot = 90
let currentTemp = 65
```

1. What is the value of this expression?

    ```swift
    primate > equid
    ```

    <details>
    <summary>Solution</summary>
    `False`
    </details>

1. What does this evaluate to?

    ```swift
    currentTemp < hot && currentTemp > cold
    ```

    <details>
    <summary>Solution</summary>
    `True`
    </details>

1. Write an expression that evaluates to true if `currentTemp` is within 5 degrees of `ideal`.
    <details>
    <summary>Solution</summary>
    `currentTemp <= ideal + 5 && currentTemp >= ideal - 5`
    </details>

### 1. If-Else

#### `if`

```swift
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
}
```

#### `else`

```swift
temperatureInFahrenheit = 40
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}
// Prints "It's not that cold. Wear a t-shirt."
```

#### `else if`

```swift
temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}
// Prints "It's really warm. Don't forget to wear sunscreen."
```

#### Exercise

Using the same constants from the previous exercise, write conditionals that output helpful messages about the temperature. See if you can work in some string interpolation.

```swift
let cold = 32
let ideal = 75
let hot = 90
let currentTemp = 65
```

1. Print a meaningful message for this condition `currentTemp < hot && currentTemp > cold`
    <details>
    <summary>Solution</summary>
    ```swift
    if currentTemp < hot && currentTemp > cold {
        print("We're having not-awful weather today!")
    }
    ```
    </details>

1. And for this one `currentTemp > hot || currentTemp < cold`
    <details>
    <summary>Solution</summary>
    ```swift
    if currentTemp < hot && currentTemp > cold {
        print("Aww, come on. This weather sucks.")
    }
    ```
    </details>

1. Print a meaningful message for this condition: currentTemp is within 5 degrees of ideal. You'll need to build the conditional first.
    <details>
    <summary>Solution</summary>
    ```swift
    if currentTemp <= ideal + 5 && currentTemp >= ideal - 5 {
        print("It is darn comfortable out.")
    }
    ```
    </details>



