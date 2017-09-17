# Conditionals

### Objective

* To understand and use `if / then / else` constructs
* To apply boolean logic to conditionals 
* To understand and use the ternary operator ` ? : `

### Reading

1. Swift Programming: The Big Nerd Ranch Guide, Chapter 3, Conditionals
1. [Swift Language Reference, Control Flow - Apple](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ControlFlow.html#//apple_ref/doc/uid/TP40014097-CH9-ID120) Seek to **Conditional Statements**

#### Further Reading
1. [Conditionals - Wiki](https://en.wikipedia.org/wiki/Conditional_(computer_programming))
	- The diagrams at the top of the page are probably the most valuable part of this page.

#### Vocabulary
- **block** - One or more lines of code inside curly braces, `{ }`.
- **branch** - A path of execution in a program.
- **dynamic** - Changing, responding to its environment. Opposite of static.

---

### 1. Introduction

Conditionals are what makes a program dynamic. Without them programs would have no way to do anything differently. We use the expression "branch" to refer to a possible path our program can take. The analogy allows us to visualize program execution as a tree. The code enters at the trunk, and as it executes it will conditionally enter branches. We might imagine the branches getting thinner as a representation of the likliness that the branch will be reached. 

> There are a few places where we use the analogy of trees and branches in Computer Science. In this case branching refers to the path of execution through a program.

#### 2. Exercise (Logic Review)

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

### 3. Control Flow

Control flow is the process by which choices are made as to which of two or more paths to follow in a program. The subject of control flow includes the conditionals we'll explore here, another conditional statement `switch`, and loops. 


#### Flow Charts

A flow chart is a somewhat outdated way of representing control flow graphically. But it is still in use as evidenced by a Google image search for [flow chart](https://www.google.com/search?tbm=isch&q=flow+chart&chips=q:flow+chart,g_2:simple&sa=X&ved=0ahUKEwiZkbO1y9nVAhVm5oMKHQwECCEQ4lYIKygA&biw=1426&bih=715&dpr=2)

XKCD, a web comic that has many scientific and computer gags has a number of [flow chart episodes](https://www.google.com/search?q=xkcd+flowchart&rlz=1C5CHFA_enUS753US753&source=lnms&tbm=isch&sa=X&ved=0ahUKEwiIsbHMy9nVAhWe2YMKHeoUBWkQ_AUICigB&biw=1426&bih=715#imgrc=qoPx7WymUgBkyM:).

### 4. if/else

#### if

`if` allows us to control entry into a block of code depending upon a boolean value or expression. 

```swift
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
}
```

The boolean expression that the `if` is testing is always followed by a block which is run if the expression evaluates to true.

#### else

`else` defines a block to be run when the `if` condition evaluates false. 

```swift
temperatureInFahrenheit = 40
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}
// Prints "It's not that cold. Wear a t-shirt."
```

Not all `if` statements need an else, but all `else`s must be attached to a preceding `if`.

### 5. Ternary Operator

The Ternary Operator (a.k.a conditional operator, ternary if, inline if), gives us a shorthand way of writing an if/else construct. Its syntax is `a ? b : c` and is read, "if a then b, otherwise c". In this case _a_ would be a boolean expression, and _b_ and _c_ can be of any type but must be the same type.


Adapting the conditional above we can rewrite it using the ternary if.

```
let temperatureInFahrenheit = 40
let message temperatureInFahrenheit <= 32 ? "cold" : "warm"
```
### 6. Nested ifs

### 7. else if

For situations where we want to check a series of conditionals in order, chosing only one we use the `else if` construct.  

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

In this example we're comparing the temperature to 32 in the `if`, and to 86 in the `else if`.  As with `if`, it doesn't require `else if` but `else if` requires an initial `if`. `else` remains optional as well. It's important to note that at most one condition will match. The conditionals are evaluated top down and in the case where more than one would have matched, only the block for the first match is run and the whole chain is exited at the end of that block.

### 8. Exercise

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


### 9. Triangle

Consider this diagram.

![Triangle tree](images/triangle_tree.png)

It models an algorithm for determining what kind of triangle we have based on the length of its sides. Convert this into a series of `if`s, printing a message when we've determined triangle type.