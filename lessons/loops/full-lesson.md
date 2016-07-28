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

# Assessment Materials
## Midday Check-in and solutions

- Exercises and solutions (add links)
- Homework and solutions (add links)

## Warm up
TODO: Some Range and conditional problems

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

```for``` implicitly declares a constant [iterator](/resources/jargon.md) that will 

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

while  {
	
}

**Question**: What do you think the following will do?

```swift
while true { // condition
	print("Hello") 
}
```

```
It will loop endlessly. 
```

Programmers put a lot of effort into avoiding endless loops because 
they generally make your program freeze and can even crash the computer it's running on. 
But you should know there are important uses for the endless loop. Apps, in fact, are running in an
endless loop as they wait for input from the user.

