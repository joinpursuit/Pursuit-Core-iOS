### Enumerations

### Objectives
* Create an enumeration and understand when it is helpful
* Create enumerations with different types of raw and associated values

### Readings
1. Swift Programming: The Big Nerd Ranch Guide, Chapter 14, Enumerations
1. [Swift Language Reference, Enumerations](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html#//apple_ref/doc/uid/TP40014097-CH12-ID145)

---

### 1. Intro to Enumerations

The main use of enumerations, ```enum``` in Swift is to make our code safer and more readable. We've heard that said generally about a lot of features in Swift. Enumerations are specifically for organizing groups or lists of related values.

From Apple:

> Each enumeration definition defines a brand new type. Like other types in Swift, their names (such as `CompassPoint` and `Planet`) should start with a capital letter. Give enumeration types singular rather than plural names, so that they read as self-evident.

```swift
enum CompassPoint {
    case North
    case South
    case East
    case West
}

let northDirection = CompassPoint.North
```

### 2. Switiching on Enum Cases

We refer to individual possible enumeration values as __cases__. It's no coincidence that this evokes the ```switch```. We'll see that while they are distinct features of the language accomplishing different things, they work very well together.  We can switch on an instance of an ```enum``` type and look for its cases in the switch's cases.

```swift
enum ErrorCode {
    case BadInput
    case NoNetwork
    case FileNotFound
}

let error = ErrorCode.NoNetwork

switch error {
case ErrorCode.BadInput:
    print("Please re-enter your information.")
case ErrorCode.NoNetwork:
    print("Please check your connection and try again.")
case ErrorCode.FileNotFound:
    print("Missing File. Please make sure your file exists at this location.")
}
```
Because Swift knows the type of the `ErrorCode` we don't need a default case because we can define an exhaustive set of `switch` cases.

### 3. Raw Value Enumerations

Enumeration cases can come prepopulated with default values, called __raw values__. Raw values can be strings, characters, or any of the integer or floating-point number types. Each raw value must be unique within its enumeration declaration.

```swift
enum NYCBoro: String {
    case Queens = "Queens"
    case Brooklyn = "Brooklyn"
    case Manhattan = "Manhattan"
    case Bronx = "Bronx"
    case StatenIsland = "Staten Island"
}
```

Raw Values are not the same as Associated Values _(discussed below)_. Raw values are set to prepopulated values when you first define the enumeration in your code. The raw value for a particular enumeration case is always the same. 

### 4. Implicitly Assigned Raw Values

When you’re working with enumerations that store integer or string raw values, you don’t have to explicitly assign a raw value for each case. When you don’t, Swift will automatically assign the values for you.

#### Using `Int` for Implicity Assigned Raw Values

When integers are used for raw values, the implicit value for each case is one more than the previous case. If the first case doesn’t have a value set, its value is 0.

```swift
enum Planet: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}
```

__Exercise__
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

### 5. Associated Values
Storing associated values alongside enumeration case values allows you to store additional custom information along with the case value, and permits this information to vary each time you use that case in your code.

You can define Swift enumerations to store associated values of any given type, and the value types can be different for each case of the enumeration if needed. 

```swift
enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
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

---

### Review and Wrapup

1. Describe the uses of `enum`.
