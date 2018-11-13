## Generics

## Readings 
[The Swift Programming Language - Generics](https://docs.swift.org/swift-book/LanguageGuide/Generics.html)

## Overview
Generic code enables you to write flexible, reusable functions and types that can work with any type, subject to requirements that you define. You can write code that avoids duplication and expresses its intent in a clear, abstracted manner.

Generics are one of the most powerful features of Swift, and much of the Swift standard library is built with generic code. In fact, you’ve been using generics throughout the Language Guide, even if you didn’t realize it. For example, Swift’s Array and Dictionary types are both generic collections. You can create an array that holds Int values, or an array that holds String values, or indeed an array for any other type that can be created in Swift. Similarly, you can create a dictionary to store values of any specified type, and there are no limitations on what that type can be.

## The Problem That Generics Solve

Define a function called swapTwoInts() 

```swift 
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
  let temporaryA = a
  a = b
  b = temporaryA
}

// test the swapTwoInts() function
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// Prints "someInt is now 107, and anotherInt is now 3"
```

[In-Out function review](https://docs.swift.org/swift-book/LanguageGuide/Functions.html#ID173)

Now we also want to swap two Strings. We would have to define a new function called swapTwoStrings() as in the defintion below

```swift 
func swapTwoStrings(_ a: inout String, _ b: inout String) {
  let temporaryA = a
  a = b
  b = temporaryA
}
```

What is we alos want to swap two Doubles 

```swift 
func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
  let temporaryA = a
  a = b
  b = temporaryA
}
```

## Generic Functions 

Generics give us a better approach to solving this duplicate function definition problem. Using Generic functions we can define a swapTwoValues function that will work on any type. 

```swift 
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
  let temporaryA = a
  a = b
  b = temporaryA
}
```

**Exercise:** Create two variable for each case a String, Double and Int and print the results of the variable before and after calling the swapTwoValues() function. 

**Exercise:** create a generic function printElement() that can take any inputArray argument e.g Double, Int or String and prints each element

## Generic Types 

In addition to generic functions, Swift enables you to define your own _generic types_. These are custom classes, structures, and enumerations that can work with any type, in a similar way to _Array_ and _Dictionary_.

**Exercise:** Let's convert the InventoryList type to a Generic Type

```swift 
struct Bike {
  var type: String
  var color: UIColor
}

struct Jean {
  var color: UIColor
  var size: Int
  var style: String
}

struct InventoryList {
  var items: [Bike]

  var isCapactityLow: Bool {
    return items.count < 2
  }

  mutating func add(item: Bike) {
    items.append(item)
  }

  mutating func remove() -> Bike {
    return items.removeLast()
  }
}

func checkInventory(inventory: InventoryList) {
  if inventory.isCapactityLow {
    print("capacity is low")
  } else {
    print("inventory is normal")
  }
}

// testing our InventoryList type
let jean = Jean(color: .blue, size: 33, style: "straight")

let roadBike = Bike(type: "Road Bike", color: .blue)
let mountainBike = Bike(type: "Mountain Bike", color: .red)
let triBike = Bike(type: "Time Trial Bike", color: .yellow)
let kidsBike = Bike(type: "Kids bike", color: .yellow)

var inventory = InventoryList(items: [roadBike, mountainBike, triBike, kidsBike])

print("there are \(inventory.items.count) items")

checkInventory(inventory: inventory)

inventory.remove()
inventory.remove()
//inventory.remove() 
//inventory.remove()

checkInventory(inventory: inventory)
```

<details>
  <summary>Solution</summary>
 
```swift 
struct InventoryList<T> {
  var items: [T]

  var isCapactityLow: Bool {
    return items.count < 2
  }

  mutating func add(item: T) {
    items.append(item)
  }

  mutating func remove() -> T {
    return items.removeLast()
  }
}

func checkInventory<T>(inventory: InventoryList<T>) {
  if inventory.isCapactityLow {
    print("capacity is low")
  } else {
    print("inventory is normal")
  }
}
```
  
</details>

