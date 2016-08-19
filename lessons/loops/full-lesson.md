# Standards
* Understand control flow
* Understand and use loops

# Objectives
Students will be able to:
* Understand and use for-in loops, collection variant
* Understand and use for-in loops, range variant
* Understand and use while loops
* Understand and use break and continue

# Resources
Swift Programming: The Big Nerd Ranch Guide, Chapter 6, Loops

Apple's [Swift Language Reference, Flow Control](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ControlFlow.html#//apple_ref/doc/uid/TP40014097-CH9-ID120)


## Warm up
```
let r = 1...5
let r2 = 1...5
```

First, type in the code above and hold Option- and click on the r (or the r2). This will bring up
the documentation on Range. It's a little scary. But I see range conforms to "Equatable". What 
do you think that means? What code would illustrate that?

## Loops
Loops are a tool for performing the same operation over a range or a list. 

**Question**: What web site or app features probably have a loop behind them?

```
Any list such as product search results on Amazon, 5 day weather forecast, a sports team roster.
Spreadsheet with formulas like SUM(A1:A10)
```

### ```for-in```

The first step here is to forget a little bit of what you learned about the syntax of
creating a loop. All the priciples, and even the inner workings are still there but we 
have a new (maybe simpler) way of defining loops.

```for``` implicitly declares a constant [iterator](/resources/jargon.md) that will be 
incremented at each iteration of the loop.

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
#### ```_```

If you only want to iterate a number of times but don't need to use the index you can replace it
with the ```_``` (underscore) character.

```swift
let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
print("\(base) to the power of \(power) is \(answer)")
```

### Sneak peek at ```Array```

```swift
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}
```

### ```for case```

A variant of for-in uses the case statement we learned as part of ```switch```. 
With this we have more control over the conditions under which the body of the loop is run.

```swift
for case let i in 1...100 where i % 10 == 5 {
    print(i)
}
```

## ```while```

```while``` loops put the initialization and increment stages of the loop in the hands of the 
programmer. It is possible to re-write a for-in style loop with ```while```:

```swift
i = 0 // initialize
while i < 10 { // condition
    print (i)  // body code

    i += 1	// increment iterator   
}
```

But it's main application is where we don't know how many times the loop will repeat before 
we enter it. 

```swift
var number = 10
while number > 1 {
    number /= 2
    print(number)
}
```

Graph this in playgrounds. We can see by changing the initial value of number there's 
not a simple way of knowing how many iterations there will be before we enter the loop. So we
enter the loop knowing the condition for exiting without knowing how many iterations will
be needed before that condition is met. 


**Question**: What do you think the following will do?

```swift
while true { // condition
	print("Hello") 
}
```

```
It will loop endlessly. 
```

**Question**: How about this one?

```swift
var number = 10
while number > 1 {
    number /= 2
    print(number)
}
```
Programmers put a lot of effort into avoiding endless loops because 
they generally make your program freeze and can even crash the computer it's running on. 
But you should know there are important uses for the endless loop. Apps, in fact, are running in an
endless loop as they wait for input from the user.

### ```repeat-while```

```swift
var i = 0
repeat {
    print(i)
    i += 1
} while i < 10

```
http://programmers.stackexchange.com/questions/268145/are-there-real-life-usage-and-applications-for-do-while-loops


### ```continue```

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

### ```break```

```swift
var shields = 5
var blastersOverheating = false
var blasterFireCount = 0
var space
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

### ```while``` Challenge

```swift
// Zeno's double secret paradox?
var doubleNumber = 20.0
while doubleNumber > 0.01 {
    doubleNumber /= 2.0
    
    print(doubleNumber)
}
```
**Question**: Using 0.01 as the threshold results in 11 iterations. But setting the
threshold to 0.0 doesn't loop endlessly as it should according to the laws of math. Why not?

```
The Double datatype doesn't have infinite precision. Halving it over and over will eventually
drive its value down to zero.
```

### Nesting

Loops can be nested. A simple way to visualize it is with a 2-dimensional matrix.

```swift
for i in 1...5 {
    for j in 1...5 {
        print("\(i),\(j)", separator: "", terminator: " ")
    }
    print("")
}
```

#### Labels

Loops can be labeled so that ```continue``` and ```break``` used in nested loops can
act on a loop other than the innermost one, which is the default.

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

If we want to find the first factors of a given product we can use 
break to escape the innermost loop.

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

**Question**: what happens when we don't break the outer loop? Don't break at all?
