# Switch

### Objective

* To understand and use `switch`
* To develop the ability to choose among variations of conditionals
* To understand switch with Tuples 
* To understand switch Ranges

### Reading

1. Swift Programming: The Big Nerd Ranch Guide, Chapter 5, Switch (pp. 35-39)
1. [Swift Language Reference, Control Flow - Apple](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ControlFlow.html#//apple_ref/doc/uid/TP40014097-CH9-ID120) Seek to **Conditional Statements > Switch**
1. [Tuples - Apple's Swift Reference](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Types.html#//apple_ref/doc/uid/TP40014097-CH31-ID448])
1. [Tuples - Apple's Swift Guide](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309)
1. [Tuples and Enums - We ❤ Swift](https://www.weheartswift.com/tuples-enums/)

#### Further Reading
1. [Conditionals - Wiki](https://en.wikipedia.org/wiki/Conditional_(computer_programming))
	- The diagrams at the top of the page are probably the most valuable part of this page.
1. [Tuple - Wiki](https://en.wikipedia.org/wiki/Tuple)

#### Vocabulary
- **branch** - A path of execution in a program.
- **tuple** - A group of zero or more values represented as one value. A tuple is defined by a comma-separated list of types, enclosed in parentheses.

---

### Introduction

The `switch` statement is a conditional that is most useful when the set of possible values we're comparing to is known. Swift's ```switch``` statement is more powerful than its predecessors in other languages so it can be used more widely. While `if/else` and `switch` can be used to implement the same logic, in many cases `switch` is more readable.

![A 4-way switch](switch.jpg)

A 4-way switch

An image like this helps to link the word "switch" to the `switch` statment. We normally think of a switch as being on or off and so the keyword is not intuitive. But if we think of the input selector on an old style stereo amplifier (I couldn't find a better image.) I think it helps to have a visual of this kind of branching.

The **type** of the cases and the operand on the `switch` line must agree. This makes sense and is consistent with our experience with Swift and its strong typing. As long as we can compare two instances of that type we can use it in a `switch`.

### 1. `switch`

```swift
switch aValue {
case onePossibleAndExpectedValueToCompareTo:
	// do something for the case of onePossibleAndExpectedValueToCompareTo
	print("First case")
case anotherPossibleAndExpectedValueToCompareTo:
	// do something for the case of anotherPossibleAndExpectedValueToCompareTo
	print("Second case")
default:
	// do something for the case when there are no matches
	print("Default case")
}
```

#### `default`

```swift
switch temperature {
case 32:
    print("\(temperature) is cold")
case 99:
    print("\(temperature) is hot")
}
```

The code above generates the error: "Switch must be exhaustive, try adding a default clause." This is one important point about `switch`: you must cover all bases (actually, all *cases*). And adding the default clause introduces a second point. If we don't want to do anything in our default case we use the keyword `break`. Swift requires an executable statement in each case. Generally, we may want to break in other matches but default is the most intuitive and therefore the most common. 


```swift
switch temperature {
case 32:
    print("\(temperature) is cold")
case 99:
    print("\(temperature) is hot")
default:
    break
}
```

#### Exercise

Let's convert this if/else chain to `switch`.

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

#### ```fallthrough```

```fallthrough``` is used to have consecutive cases match. There are not many common uses for it but can be used to avoid repeating code.

```swift
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)
```

### 2. `switch` with `Range` 

```switch``` can also match values in ranges. This introduces the ```Range``` type. Let's look at a range by itself before we see it in the context of ```switch```. The ```Range``` is always defined by two numbers: the upper bound and the lower bound. There are two forms, one that *doesn't* include the higher bound and one that does. 

```swift
let r = 0..<5
print(type(of: r))

let cardValues = 1...13
print(type(of:cardValues))

// Prints:
// CountableRange<Int>
// CountableClosedRange<Int>
```

> Specifically, `CountableRange<Int>` and `CountableClosedRange<Int>` are generic `struct`s. We'll cover `struct` in detail later in the course and will work some with generics as well. Ranges will also be used to define the upper and lower limits of loops. For now we will just focus on their use in `switch` `case`s.

We can use `Range`s in our `switch` `case`s.

```swift
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
var naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")
// Prints "There are dozens of moons orbiting Saturn."
```

### 3. Tuples

The ```switch``` statement also allows for matching on tuples. A tuple is a grouping of a set of related variables into one. Let's look at Tuples on their own before we use them within a `switch`.

Tuples get their name from the sequence of multiples we're familiar with, starting with single, double, triple, quadruple, quintuple, etc. From this mathematicians coined the term n-tuple, and it's shortened to tuple. Because many common examples of tuples happen to have two elements, and how the term sounds like "duplicate", and "two", it's easy to think tuples denotes two parts. But this is not the case. There can be many items in a tuple.


```swift
// independent constants
let name = "Agnes"
let age = 24
let zipcode = 11106

// one tuple agnesInfo now contains a list of values
var agnesInfo = (name, age, zipcode)

let hollyInfo = ("Holly", 33, "10301") // can be built from literals; note the type of zip
```

If you enter the above block in a playground you'll see agnesInfo broken into numbered components, 0, 1 and 2. We haven't discussed Swift arrays yet but you're familiar with them from the Workshop at least and might recognize the numbers as zero-based array indexes. *variableName*.*index* is the syntax to access the tuple items from the variable. For example:

```swift
agnesInfo.2 // gets Agnes's zipcode

agnesInfo.1 = 34 // Agnes just had a birthday so let's update her
```

Let's take a closer look at our tuples types.

```swift
print(type(of: agnesInfo))
// (String, Int, Int)

print(type(of: hollyInfo))
// (String, Int, String)
```

Note how the type is represented as a collection of other types. It follows a specific pattern. What happens when we try to assign `hollyInfo` to `agnesInfo`? 

<details>
<summary>Try `agnesInfo = hollyInfo`</summary>
```
Playground execution failed: error: MyPlayground.playground:49:13: error: cannot assign value of type '(String, Int, String)' to type '(String, Int, Int)'
agnesInfo = hollyInfo
            ^~~~~~~~~
```
</details>

<details>
<summary>How could you fix this bug?</summary>

Change the type of one of the tuples to match the other.

```swift
let hollyInfo = ("Holly", 33, 10301) 
var agnesInfo = ("Agnes", 24, 11106)
agnesInfo = hollyInfo
```

- OR -

```swift
let hollyInfo = ("Holly", 33, "10301") 
var agnesInfo = ("Agnes", 24, "11106")
agnesInfo = hollyInfo
```

</details>

We could choose to name the elements of the Tuple to make working with their elements easier to read.

```swift
let hollyInfo = (name: "Holly", age: 33, zip: 10301)
print(hollyInfo.name)
```

> Note how the underlying type of the Tuple doesn't change when we name the elements. `hollyInfo` is still of type `(String, Int, Int)`. This is evidenced by the fact that we can still assign `hollyInfo` to `agnesInfo`  for which we haven't named its elements.

#### Exercise

* Declare some tuples and inspect their component values.

#### 4. ```switch``` with Tuples

So let's look at a ```switch``` with a tuple. Remember how a tuple's type is a collection of types that follow a specific pattern. Swift uses pattern matching in its `switch` cases to match specific combinations of tuple elements.

```swift
let agnesInfo = ("Agnes", 24, 11106)
let hollyInfo = ("Holly", 33, 10301)
let kaiInfo = ("Kai", 18, 11106)

// because personInfo is a var we can assign it any of the constants above
var personInfo = kaiInfo

switch personInfo {
case (_, 0..<30, 10300...10399):
    print("\(personInfo.0) is young and lives on Staten Island")
case (_, 0..<30, 11100...11199):
    print("\(personInfo.0) is young and lives in LIC")
case (_, 0..<30, _):
    print("\(personInfo.0) is young and we don't know where they live")
case (_, _, 10000...14999):
    print("\(personInfo.0) lives in New York State")
default:
    print("We can't say anything interesting about \(personInfo.0)")
}
```

### 5. Exercises

1. Create enough tuples of the (String, Int, Int) type to to hit every case in the switch above.
1. Add a case that matches all people named "Agnes". How does the placement of the case affect the output?


