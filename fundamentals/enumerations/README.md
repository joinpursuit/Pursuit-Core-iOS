### Enumerations

### Objectives
* Create an enumeration and understand when it is helpful
* Create enumerations with different types of raw and associated values
* Iterate over an enum by conforming to the CaseIterable protocol and using the allCases property

### Readings
1. [Swift Language Reference, Enumerations](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html#//apple_ref/doc/uid/TP40014097-CH12-ID145)

---

### 1. Intro to Enumerations

An enumeration defines a common type for a group of related values and enables you to work with those values in a type-safe way within your code.

Enumerations in Swift are first-class types in their own right. They adopt many features traditionally supported only by classes, such as computed properties to provide additional information about the enumeration’s current value, and instance methods to provide functionality related to the values the enumeration represents. Enumerations can also define initializers to provide an initial case value; can be extended to expand their functionality beyond their original implementation; and can conform to protocols to provide standard functionality.

> Each enumeration definition defines a brand new type. Like other types in Swift, their names (such as `CompassPoint` and `Planet`) should start with a capital letter. Give enumeration types singular rather than plural names, so that they read as self-evident.

**Enumeration Syntax**  

```swift
enum SomeEnumeration {
  // enumeration definition goes here
}
```

CompassPoint enumeraton   

```swift
enum CompassPoint {
    case north
    case south
    case east
    case west
}

// You use the case keyword to introduce new enumeration cases

let northDirection = CompassPoint.north
```

**Exercise**:

Defining enumerations:

Make enums that represent the following:

**Part 1**  
1. Left and right hands
2. Days in a week
3. Blood types (A, B, O, AB)
4. Coins in U.S currency

**Part 2**  
Switch on the enums you created above to do the following:

1. Print out whether or not the left hand
2. Print out whether or not it's a weekday
3. Print out whether or not the blood type is type B
4. Print out if the value of the coin is 10 cents or higher


### 2. Switiching on Enum Cases

We refer to individual possible enumeration values as __cases__. It's no coincidence that this evokes the ```switch```. We'll see that while they are distinct features of the language accomplishing different things, they work very well together.  We can switch on an instance of an ```enum``` type and look for its cases in the switch's cases.

```swift
enum ErrorCode {
    case badInput
    case noNetwork
    case fileNotFound
}

let error = ErrorCode.noNetwork

switch error {
case .badInput:
    print("Please re-enter your information.")
case .noNetwork:
    print("Please check your connection and try again.")
case .fileNotFound:
    print("Missing File. Please make sure your file exists at this location.")
}
```
Because Swift knows the type of the `ErrorCode` we don't need a default case because we can define an exhaustive set of `switch` cases. If the case for `.fileNotFound` is omitted, this code would not compile, because it does not consider the complete list of `ErrorCode` cases. Requiring exhaustiveness ensures that enumeration cases are not accidentally omitted. When it is not appropriate to provide a case for every enumeration case, you can provide a default case to cover any cases that are not addressed explicitly.

### 3. Case Iterable

For some enumerations, it’s useful to have a collection of all of that enumeration’s cases. You enable this by writing : CaseIterable after the enumeration’s name. Swift exposes a collection of all the cases as an allCases property of the enumeration type. Here’s an example:

```swift
enum CompassPoint: CaseIterable {
  case North
  case South
  case East
  case West
}

let move = CompassPoint.East

switch move {
case .North:
  print("moving north")
case .South:
  print("moving south")
case .East:
  print("moving east")
case .West:
  print("moving west")
}

print("there are \(CompassPoint.allCases.count) compass points")

// iterating through an enum
for point in CompassPoint.allCases {
  print(point)
}
```

### 4. Raw Value Enumerations

Enumeration cases can come prepopulated with default values, called __raw values__. Raw values can be strings, characters, or any of the integer or floating-point number types. Each raw value must be unique within its enumeration declaration.

```swift
enum NYCBoro: String {
    case queens = "Queens"
    case brooklyn = "Brooklyn"
    case manhattan = "Manhattan"
    case bronx = "Bronx"
    case statenIsland = "Staten Island"
}
```

Raw Values are not the same as Associated Values _(discussed below)_. Raw values are set to prepopulated values when you first define the enumeration in your code. The raw value for a particular enumeration case is always the same.

**Exercise**:
1. Redefine each of your enums in the previous exercises to have raw values
2. Then, initialize a new instance of each enum with its raw value
   e.g
   ```swift
   // initializing from a rawValue
    if let borough = NYCBoro(rawValue: "Queens") {
      if borough.rawValue == "Queens" {
        print("welcome to Queens where diversity lives")
      }
    }
   ```
3. What happens if you give an invalid raw value to instantiate an enum?  Try it and see.


### 5. Implicitly Assigned Raw Values

When you’re working with enumerations that store integer or string raw values, you don’t have to explicitly assign a raw value for each case. When you don’t, Swift will automatically assign the values for you.

#### Using `Int` for Implicity Assigned Raw Values

When integers are used for raw values, the implicit value for each case is one more than the previous case. If the first case doesn’t have a value set, its value is 0.

```swift
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
```

**Exercise_**
Create an ```enum``` for the HTTP error codes 400-409 using implicitly assigned raw values. Refer to these [Status Code Definitions](https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html).

#### Using `String` for Implicity Assigned Raw Values

When strings are used for raw values, the implicit value for each case is the text of that case’s name.

```swift
enum CompassPoint: String {
    case north, south, east, west
}
```

In the example above, `CompassPoint.south` has an implicit raw value of "south", and so on.

#### Accessing Raw Values

You can access the raw value of an enumeration case with its `rawValue` property.

```swift
let earthsOrder = Planet.earth.rawValue
// earthsOrder is 3

let sunsetDirection = CompassPoint.west.rawValue
// sunsetDirection is "west"
```

**Exercise**

Give default raw values to each of the enums from the previous exercises


### 6. Associated Values
Storing associated values alongside enumeration case values allows you to store additional custom information along with the case value, and permits this information to vary each time you use that case in your code.

You can define Swift enumerations to store associated values of any given type, and the value types can be different for each case of the enumeration if needed.

```swift
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
```

This definition does not provide any actual `Int` or `String` values — it just defines the type of associated values that `Barcode` constants and variables can store when they are equal to `Barcode.upc` or `Barcode.qrCode`. New barcodes can then be created with either type:

This example creates a new variable called `productBarcode` and assigns it a value of `Barcode.upc` with an associated tuple value of `(8, 85909, 51226, 3)`.

```swift
var productBarcode = Barcode.upc(8, 85909, 51226, 3)
```

The same product can be assigned a different type of barcode:

```swift
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
```

At this point, the original `Barcode.upc` and its integer values are replaced by the new `Barcode.qrCode` and its string value. Constants and variables of type `Barcode` can store _either_ a `.upc` or a `.qrCode` (together with their associated values), but they can only store one of them at any given time.

#### Extracting Associated Values with a Switch Statement

The different barcode types can be checked using a switch statement, as before. This time, however, the associated values can be extracted as part of the switch statement. You extract each associated value as a constant (with the `let` prefix) or a variable (with the `var` prefix) for use within the switch case’s body:

```swift
switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}
// Prints "QR code: ABCDEFGHIJKLMNOP."
```

If all of the associated values for an enumeration case are extracted as constants, or if all are extracted as variables, you can place a single var or let annotation before the case name, for brevity:

```swift
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}
// Prints "QR code: ABCDEFGHIJKLMNOP."
```

**Exercise**

Rewrite the blood type enum to have an associated value of if the type is positive or negative

---


### Standards

IOS: IOS.1, IOS.1.b

Language Fundamentals: LF.3
