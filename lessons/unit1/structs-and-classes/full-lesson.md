### Structs & Classes
---

### Objectives
* Understand the differences between structs and classes
* To create and initialize structs and classes
* Understand when to use a struct vs a class
* Understand that structures are value types and what this implies

### Readings
1. Swift Programming: The Big Nerd Ranch Guide, Chapter 15, Structs and Classes
1. Apple's [Swift Language Reference, Classes and Structures](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html#//apple_ref/doc/uid/TP40014097-CH13-ID82)
1. [Swift Language Reference, Methods](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Methods.html#//apple_ref/doc/uid/TP40014097-CH15-ID234)

#### Vocabulary
1. **Instance** - 

---

### 1. Intro

From the Apple documentation:

> An instance of a class is traditionally known as an object. However, Swift classes and structures are much closer in functionality than in other languages, and much of this chapter describes functionality that can apply to instances of either a class or a structure type. Because of this, the more general term instance is used.

Whenever you define a new class or structure, you effectively define a brand new Swift type. Give types `UpperCamelCase` names (i.e. `SomeClass`, `SomeStructure`) to match the capitalization of standard Swift types (such as `String`, `Int`, and `Bool`). Conversely, always give properties and methods `lowerCamelCase` names (such as `frameRate` and `incrementCount`) to differentiate them from type names. **- Apple**

### 2. Comparing Classes and Structures

From the Apple documentation:

> Classes and structures in Swift have many things in common. Both can:
> 
> * Define properties to store values
> * Define methods to provide functionality
> * Define subscripts to provide access to their values using subscript syntax
> * Define initializers to set up their initial state
> * Be extended to expand their functionality beyond a default implementation
> * Conform to protocols to provide standard functionality of a certain kind
>
> For more information, see Properties, Methods, Subscripts, Initialization, Extensions, and Protocols.
> 
> Classes have additional capabilities that structures do not:
> 
> * Inheritance enables one class to inherit the characteristics of another.
> * Type casting enables you to check and interpret the type of a class instance at runtime.
> * Deinitializers enable an instance of a class to free up any resources it has assigned.
> * Reference counting allows more than one reference to a class instance.

### 3. Definition Syntax

Classes and structures have a similar definition syntax. You introduce classes with the class keyword and structures with the struct keyword. Both place their entire definition within a pair of braces.

```swift
class SomeClass {
    // class definition goes here
}

struct SomeStructure {
    // structure definition goes here
}
```

### 3. Stored Properties

Properties are constants and variables encapsulated inside classes and structures.

> From Apple:

```swift
struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
```


### 4. Creating Instances of Structs & Classes

The `Resolution` structure definition and the `VideoMode` class definition only describe what a `Resolution` or `VideoMode` will look like. They themselves do not describe a specific resolution or video mode. To do that, you need to create an instance of the structure or class. Structures and classes both use **initializer syntax** for new instances.

```swift
let lowRes = Resolution(width: 800, height: 600)
```

#### Default Initializers 
In a default initializer, the name of the type is followed by empty parentheses. You can use default initializers when your types either don’t have any stored properties, or when all of the type’s stored properties have default values. This holds true for both structures and classes.

```swift
let someResolution = Resolution()
let someVideoMode = VideoMode()
```

Declaring an optional stored property as a constant (without an intial value) will inhibit you from using a default initializer. Declaring your optional properties as variables still enables us to use a default initializer, even if that variable optional has not been given an initial value. The reason for that is because the value contained in a variable can be changed at any point after their initialization, while a constant can never be changed. So, an optional that is declared as a constant with no inital value can never be given a value at any other point. Remember, when you are creating an instance of a new type, all of its properties must be properly instantiated with values.

#### Memberwise Initializers (for Structs only!)



#### Accessing Properties

You can access the properties of an instance using **dot syntax**. In dot syntax, you write the property name immediately after the instance name, separated by a period (.), without any spaces:

```swift
print("The width of someResolution is \(someResolution.width)")
print("The width of lowRes is \(lowRes.width)")
```



### 5. Classes are Reference types

> From Apple:

```swift
let hd = Resolution(width: 1920, height: 1080)
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
```

---

### 6. Inheritance

In my opinion there's a little too much fascination with inheritance. It is necessary to learn, but you spend more time simply modeling one thing than you do developing a hierarchy.

To get started, **encapsulation** is the more important concept to understand than inheritance is.

### 7. Instance methods



### 8. Type Methods

```static``` in ```struct```s and ```class``` in ```class```.

### 9. Review and Wrapup

* Compare and contrast the use of ```struct``` and ```class```.
* What are type methods?

### 10. Project
Link to Project
 
