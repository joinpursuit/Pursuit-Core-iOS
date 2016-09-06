# Standards
Solve problems with Enumerations, Structures and Classes

# Objectives
* Create an enumeration and understand when it is helpful
* Create enumerations with different types of raw and associated values

# Resources
Swift Programming: The Big Nerd Ranch Guide, Chapter 14, Enumerations

Apple's [Swift Language Reference, Enumerations](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html#//apple_ref/doc/uid/TP40014097-CH12-ID145)

## Warm up



# Lecture

The main use of enumerations, ```enum``` in Swift is to make our code safer and more 
readable. We've heard that said generally about a lot of features in Swift. Enumerations
are specifically for organizing groups or lists of related values.

From Apple:

> Each enumeration definition defines a brand new type. Like other types in Swift, their names (such as
> CompassPoint and Planet) should start with a capital letter. Give enumeration types singular rather than 
> plural names, so that they read as self-evident:

We refer to individual possible enumeration values as "cases". It's no coincidence that this evokes the 
```switch```. We'll see that while they are distinct features of the language accomplishing different
things, they work very well together.  We can switch on an instance of an ```enum``` type and look
for its cases in the switch's cases. Because Swift knows the type of the ```enum``` we don't need a
default case because we can define an exhaustive set of ```switch``` cases.

## Enumerations

```swift
enum ErrorCode {
    case BadInput
    case NoNetwork
    case FileNotFound
}
```
> From Apple:

```swift
enum CompassPoint {
    case North
    case South
    case East
    case West
}
```

```swift
enum UserMessage: String {
    case Greeting = "Hello good person!"
    case Farewell = "Fare thee well, come again."
    case Prompt = ">>>"
}
```

### Basic Enumerations

### Raw Value Enumerations

* not the same as associated values
* must be unique in the enumeration
* need to be the same type
* initialize from raw value

```swift
enum NYCBoro: String {
    case Queens = "Queens"
    case Brooklyn = "Brooklyn"
    case Manhattan = "Manhattan"
    case Bronx = "Bronx"
    case StatenIsland = "Staten Island"
}
```

#### Implicitly Assigned Raw Values

By adding an int value.

```swift
enum Planet: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}
```

> **NYT**: Create an ```enum``` for the HTTP error codes 400-409 using implicitly assigned raw values. Refer to https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html.

Automatic raw ```String``` value.

```swift
enum CompassPoint: String {
    case North, South, East, West
}
```


### Associated Values

> Apple documentation has this one.

```swift
enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}
```

```swift
enum Instrument {
    case Trumpet(String, Int)
    case Guitar(String, String, String, String, String, String)
    case Violin(String, String, String, String)
    case Cello(String, String, String, String)
}
```

### Recursive Enumerations 

This is interesting. Don't use it.

## Exercises

# Review and Wrapup

* Describe the uses of ```enum```.
