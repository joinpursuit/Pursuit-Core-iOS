# Standards
Solve problems with Enumerations, Structures and Classes

# Objectives
* Create an enumeration and understand when it is helpful
* Use methods in enumerations
* Create enumerations with different types of associated values

# Resources
Swift Programming: The Big Nerd Ranch Guide, Chapter 14, Enumerations

Apple's [Swift Language Reference, Enumerations](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html#//apple_ref/doc/uid/TP40014097-CH12-ID145)

# Assessment Materials
## Midday Check-in and solutions

- Exercises and solutions (add links)
- Homework and solutions (add links)

## Warm up

* enumeration "cases"
* Types and naming:
Each enumeration definition defines a brand new type. Like other types in Swift, their names (such as CompassPoint and Planet) should start with a capital letter. Give enumeration types singular rather than plural names, so that they read as self-evident:
* switches are exhaustive!

# Lecture

## Enumerations

### Basic Enumerations

### Raw Value Enumerations
* not the same as associated values
* must be unique in the enumeration
* need to be the same type
* initialize from raw value

####Implicitly Assigned Raw Values

```swift
enum Planet: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}
```

### Methods

### Associated Values

```swift
enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}
```

### Recursive Enumerations 

This is interesting. Don't use it.

## Exercises

# Review and Wrapup

* Describe the uses of ```enum```.
