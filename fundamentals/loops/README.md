# Loops
---

### Objective
- To understand and determine how and when to use loops
- To understand and use `while` loops
- To understand and use  `for-in` loops, in both the collection and range variants
- To understand control flow through the use of `break` and `continue`

### Readings

1. Apple's [Swift Language Reference, Flow Control](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/ControlFlow.html)

#### Vocabulary

1. **iteration** - the repetition of a process in a computer program. When the first set of instructions is executed again, it is called an iteration. -[Techopedia](https://www.techopedia.com/definition/3821/iteration)
1. **iterator** - an object that enables a programmer to traverse a container, particularly lists. -[Wikipedia](https://en.wikipedia.org/wiki/Iterator)

---

### 1. Warm up

```swift
let closedRange = 1...5
let openRange = 1..<5
```
In Xcode, hold option and click on the constants declared above. They're of types `CountableClosedRange<Int>` and `CountableRange<Int>`. There's a lot going on behind the scenes, but being _countable_ means they can be used as iterators. This isn't true of all ranges. Consider:

```swift
let range = 1...5.0
```

Here, `range` is of type `ClosedRange<Double>` and it is not iterable.


### 2. Introduction

Loops are a tool for performing the same operation over a range or a list. We can say the loop "iterates" over the range/list.

**Question**: What web site or app features probably have a loop behind them?

<details>
<summary><b>Solution</b></summary>


> * Any list such as product search results on Amazon, 5 day weather forecast, a sports team roster.
> * Spreadsheet with formulas like SUM(A1:A10)

</details>


### 3. ```for-in```

The first step here is to forget a little bit of what you might have learned about the syntax of `for` loops. All the principles, and even the inner workings are still there but we have a new (maybe simpler) way of defining loops.

`for` implicitly declares a constant iterator with the identifier you provide. The iterator will be incremented (increased by one) at each iteration of the loop.


```swift
for i in 0..<10 {
    print(i)
}
```

#### Exercise

Print out the first five multiples of 5.

<details>
<summary>Solution</summary>

```swift
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

// 1 times 5 is 5
// 2 times 5 is 10
// 3 times 5 is 15
// 4 times 5 is 20
// 5 times 5 is 25
```

</details>

### 4. ```_```

If you want to use a loop to iterate a certain number of times, but don't need to refer to the iterator inside the loop, you can replace it with the `_` (underscore) character.

```swift
for _ in 0..<10 {
    print("Hello there!")
}
```


#### Exercise

Given,

```swift
let base = 3
let power = 10
```

Write a loop that calculates 3 to the 10th power.

<details>
    <summary>Solution</summary>

```swift
let base = 3
let power = 10
var answer = 1

for _ in 1...power {
    answer *= base
}

print("\(base) to the power of \(power) is \(answer)")
```

</details>

### 5. Sneak peek at ```Array```

Since loops and arrays are so closely tied, let's look at a brief example of a `for` loop that iterates over an array, printing its values. We'll revisit this at length in the Arrays lesson.

```swift
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}
```

### 6. ```where``` clauses

A variant of for-in uses the `where` clause that we learned as a part of the ```switch``` statement. With this, we have more control over the conditions that run in the body of the loop.

The `where` clause provides a logical test that must be met in order to execute the loop’s code. If the condition established by the `where` clause is not met, then the loop’s code is not run.

```swift
for i in 1...100 where i % 10 == 5 {
    print(i)
}
```

### 7. `while`

`while` loops put the initialization and increment stages of the loop in the hands of the programmer. It is possible to re-write a for-in style loop with `while`:

```swift
var i = 0 // initialize

while i < 10 { // condition
    print (i)  // body code

    i += 1	// increment iterator   
}
```

But `while` loops are usually used when **we don't know** how many times the loop will repeat before we enter it.

```swift
var number = 10

while number > 1 {
    number /= 2
    print(number)
}
```

***Graph the snippet above in playgrounds.***

We can see by changing the initial value of number there's not a simple way of knowing how many iterations there will be before we enter the loop. So we enter the loop knowing the condition for exiting without knowing how many iterations will be needed before that condition is met.

**Question**: What do you think the following will do?

```swift
while true { // condition
    print("Hello")
}
```

<details>
<summary><b>Solution</b></summary>

>It will loop endlessly.

</details>

**Question**: How about this one?

```swift
var number = 10
while number > 1 {
    number /= 2
    print(number)
}
```

<details>
<summary><b>Solution</b></summary>

>This loop will run 3 times.

```swift
// Expected Output
5
2
1
```

</details>


Programmers put a lot of effort into avoiding endless loops because they generally make your program freeze and can even crash the computer it's running on. But you should know there are important uses for the endless loop. Apps, in fact, are running in an endless loop as they wait for input from the user.

```swift
// Zeno's double secret paradox?
var doubleNumber = 20.0
while doubleNumber > 0.01 {
    doubleNumber /= 2.0

    print(doubleNumber)
}
```

**Question**: Using 0.01 as the threshold results in 11 iterations. But setting the threshold to 0.0 doesn't loop endlessly as it should according to the laws of math. Why not?

<details>
<summary><b>Solution</b></summary>

>The Double datatype doesn't have infinite precision. Halving it over and over will eventually drive its value down to zero.

</details>



### 8. ```repeat-while```

```swift
var i = 0
repeat {
    print(i)
    i += 1
} while i < 10

```

[Real Life Applications of Do-While Loops](http://programmers.stackexchange.com/questions/268145/are-there-real-life-usage-and-applications-for-do-while-loops)
> In Swift 3+, `do-while` loops are actually `repeat-while`


### 9. ```continue```

```swift
var shields = 5
var blastersOverheating = false
var blasterFireCount = 0

while shields > 0 {

    if blastersOverheating {
        print("Blasters are overheated!  Cooldown initiated.")
        sleep(5)
        print("Blasters ready to fire")
        sleep(1)
        blastersOverheating = false
        blasterFireCount = 0
    }

    if blasterFireCount > 100 {
        blastersOverheating = true
        continue
    }

    // Fire blasters!
    print("Fire blasters!")

    // note the version in the book used ++
    blasterFireCount += 1
}
```

***Note: This code will execute indefinitely.***

### 10. ```break```

```swift
var shields = 5
var blastersOverheating = false
var blasterFireCount = 0
var spaceDemonsDestroyed = 0

while shields > 0 {

    if spaceDemonsDestroyed == 500 {
        print("You beat the game!")
        break
    }

    if blastersOverheating {
        print("Blasters are overheated! Cooldown initiated.")
        sleep(5)
        print("Blasters ready to fire")
        sleep(1)
        blastersOverheating = false
        blasterFireCount = 0
        continue
    }

    if blasterFireCount > 100 {
        blastersOverheating = true
        continue
    }

    // Fire blasters!
    print("Fire blasters!")
    blasterFireCount += 1
    spaceDemonsDestroyed += 1
}
```

### 11. Nesting

Loops can be nested. A simple way to visualize it is with a 2-dimensional matrix.

```swift
for i in 1...5 {
    for j in 1...5 {
        print("\(i),\(j)", separator: "", terminator: " ")
    }
    print("")
}
```

### 12. Labels

Loops can be labeled so that ```continue``` and ```break``` used in nested loops can act on a loop other than the innermost one, which is the default.

Here we have a loop that counts from 1 to the current value of `i` 5 times.

```swift
outer: for i in 1...5 {
    print("i\(i) :", terminator: " ")

    inner: for j in 1...5 {
        if i == j {
            // uncomment for "outer"
             print("")

            // toggle outer on and off
            continue outer
        }
        print("j\(j)", terminator: " ")
    }
    print("")
}
```

If we want to find the first factors of a given product, we can use break to escape the outer loop as soon as it's found.

```swift
let product = 24
outer: for i in 1...12 {
    inner: for j in 1...12 {
        if i * j == product {
            print("\(product) = \(i) x \(j)")
            break outer
        }
        else {
            print("Dud: \(i) \(j)")
        }
    }
}
```

**Question**: What happens when we don't break the outer loop? Don't break at all?

<details>
<summary><b>Solution</b></summary>

>With the current break, once we find the combination of i and j whose product is equal to `product`, we break the outer loop which would subsequently stop the nested inner loop as well. If we don't break the outer loop, the outer loop would continue to execute until it reaches the upper bound of its range. Not breaking the outer loop has the same effect as not breaking at all.

</details>

### Standards

IOS: IOS.1

Language Fundamentals: LF.4
