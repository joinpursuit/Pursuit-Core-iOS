# Loops
---

### Objective
- To understand and determine how and when to use loops
- To understand and use `while` loops
- To understand and us  `for-in` loops, in both the collection and range variants
- To understand control flow through the use of `break` and `continue`

### Readings

1. Swift Programming: The Big Nerd Ranch Guide, Chapter 6, Loops
1. Apple's [Swift Language Reference, Flow Control](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/ControlFlow.html)

#### Vocabulary

1. **Iteration** - the repetition of a process in a computer program. When the first set of instructions is executed again, it is called an iteration. -[Techopedia](https://www.techopedia.com/definition/3821/iteration)
1. **Iterator** - an object that enables a programmer to traverse a container, particularly lists. -[Wikipedia](https://en.wikipedia.org/wiki/Iterator)

---

### 1. Warm up
```
let r = 1...5
let r2 = 1...5
```

First, type in the code above and hold Option- and click on the r (or the r2). This will bring up the documentation on Range. It's a little scary. But I see range conforms to "Equatable". What do you think that means? What code would illustrate that?

### 1. Introduction
Loops are a tool for performing the same operation over a range or a list. 

**Question**: What web site or app features probably have a loop behind them?

<details>
<summary><b>Solution</b></summary>


> * Any list such as product search results on Amazon, 5 day weather forecast, a sports team roster.
> * Spreadsheet with formulas like SUM(A1:A10)

</details>


### 2. ```for-in```

The first step here is to forget a little bit of what you learned about the syntax of creating a loop. All the priciples, and even the inner workings are still there but we have a new (maybe simpler) way of defining loops.

```for``` implicitly declares a constant iterator that will be incremented at each iteration of the loop.

```swift
for currentNumber in 3..<18 {
    print(currentNumber)
}
```

```swift
//Make this the "You Do"
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
// 1 times 5 is 5
// 2 times 5 is 10
// 3 times 5 is 15
// 4 times 5 is 20
// 5 times 5 is 25
```
### 3. ```_```

If you only want to iterate a number of times but don't need to use the index you can replace it with the ```_``` (underscore) character.

```swift
for _ in 0..<10 {
    print("Hello there!")
}
```

```swift
//Probably give this as an exercise
let base = 3
let power = 10
var answer = 1

for _ in 1...power {
    answer *= base
}

print("\(base) to the power of \(power) is \(answer)")
```

### 4. Sneak peek at ```Array```

```swift
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}
```

### 5. ```where``` clauses

A variant of for-in uses the `where` clause that we learned as a part of the ```switch``` statement. With this, we have more control over the conditions under which the body of the loop is run. 

The `where` clause provides a logical test that must be met in order to execute the loop’s code. If the condition established by the `where` clause is not met, then the loop’s code is not run.

```swift
for i in 1...100 where i % 10 == 5 {
    print(i)
}
```

### 6. ```while```

```while``` loops put the initialization and increment stages of the loop in the hands of the programmer. It is possible to re-write a for-in style loop with ```while```:

```swift
i = 0 // initialize

while i < 10 { // condition
    print (i)  // body code

    i += 1	// increment iterator   
}
```

But it's main application is where we don't know how many times the loop will repeat before we enter it. 

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



### 7. ```repeat-while```

```swift
var i = 0
repeat {
    print(i)
    i += 1
} while i < 10

```

[Real Life Applications of Do-While Loops](http://programmers.stackexchange.com/questions/268145/are-there-real-life-usage-and-applications-for-do-while-loops)
> In Swift 3+, `do-while` loops are actually `repeat-while`


### 8. ```continue```

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

### 9. ```break```

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

### 10. Nesting

Loops can be nested. A simple way to visualize it is with a 2-dimensional matrix.

```swift
for i in 1...5 {
    for j in 1...5 {
        print("\(i),\(j)", separator: "", terminator: " ")
    }
    print("")
}
```

### 11. Labels

Loops can be labeled so that ```continue``` and ```break``` used in nested loops can act on a loop other than the innermost one, which is the default.

```swift
outer: for i in 1...5 {
    print("\(i) :", separator: "", terminator: " ")

    inner: for j in 1...5 {
        if i == j {
            // uncomment for "outer"
            // print("")
            
            // toggle outer on and off
            continue outer
        }
        print("\(j)", separator: "", terminator: " ")
    }
    print("")
}
``` 

If we want to find the first factors of a given product, we can use break to escape the innermost loop.

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

>With the current break as-is, once we find the combination of i and j whose product is equal to `product`, we break the outerloop which would subsequenlty stop the nested innerloop as well. If we don't break the outerloop, the outerloop would continue to exeucte until it reaches the upperbound of its range. Not breaking the outerloop has the same effect as not breaking at all. 

</details>
