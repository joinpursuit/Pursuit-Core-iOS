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
1. **Base Class** -  a class that does not inherit from another class.
1. **Encapsulation** - means that objects keep their state information private.
1. **Inherit/Inheritance** - means that objects of one class can derive part of their behavior from a base or parent class. When one class inherits from another, the inheriting class is known as a __subclass__, and the class it inherits from is known as its __superclass__. 
1. **Initialization** - the process of preparing an instance of a class, structure, or enumeration for use by setting an initial value for each stored property on that instance.
1. **Instance** - a single and unique member of a class (or structure) that has specified values rather than variables, and represents an object. In a non-programming context, you could think of "dog" as a class and your particular pet dog as an instance of that class.
1. **Instantiation** - "Humans are born. Objects are instantiated. A baby is an instance of a Human, an object is an instance of some Class." [-More on Initialization vs Instantiation](https://stackoverflow.com/questions/2330767/what-is-the-difference-between-instantiated-and-initialized)
1. **Method** - a function that is associated with a class. _All methods are functions, but not all functions are methods._
1. **Object-Oriented Programming** - programming paradigm that represents the concept of “objects” that have properties (attributes that describe the object), and associated procedures/functions known as methods. [-WeHeartSwift](https://www.weheartswift.com/object-oriented-programming-swift/)
1. **Property** - a variable or constant value that is associated with a class.

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

Classes and structures have a similar definition syntax. You introduce classes with the `class` keyword and structures with the `struct` keyword. Both place their entire definition within a pair of braces.

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

Declaring an optional stored property as a constant (without an intial value) will inhibit you from using a default initializer. 

Declaring your optional properties as variables still enables us to use a default initializer, even if that variable optional has not been given an initial value. The reason for that is because the value contained in a variable can be changed at any point after their initialization, while a constant can never be changed. So, an optional that is declared as a constant with no inital value can never be given a value at any other point. Remember, when you are creating an instance of a new type, all of its properties must be properly initialized.

#### Memberwise Initializers (for Structs only!)

Structure types automatically receive a memberwise initializer if they do not define any of their own custom initializers. Unlike a default initializer, the structure receives a memberwise initializer even if it has stored properties that do not have default values.

The memberwise initializer is a shorthand way to initialize the member properties of new structure instances. Initial values for the properties of the new instance can be passed to the memberwise initializer by name.

```swift
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0) //free memberwise initializer provided for all structs
```

Note that if you define a custom initializer for a value type, you will no longer have access to the default initializer (or the memberwise initializer, if it is a structure) for that type. 

>If you do want your custom value type to be initializable with the default initializer and memberwise initializer, and also with your own custom initializers, write your custom initializers in an extension rather than as part of the value type’s original implementation.

#### Accessing Properties

You can access the properties of an instance using **dot syntax**. In dot syntax, you write the property name immediately after the instance name, separated by a period (.), without any spaces:

```swift
print("The width of someResolution is \(someResolution.width)")
print("The width of lowRes is \(lowRes.width)")
```

---

### 5. Classes are Reference Types

Unlike value types, reference types are not copied when they are assigned to a variable or constant, or when they are passed to a function. Rather than a copy, a reference to the same existing instance is used instead.

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

Because classes are reference types, `tenEighty` and `alsoTenEighty` actually both refer to the same `VideoMode` instance. Effectively, they are just two different names for the same single instance.

Note that `tenEighty` and `alsoTenEighty` are declared as constants, rather than variables. However, you can still change `tenEighty.frameRate` and `alsoTenEighty.frameRate` because the values of the `tenEighty` and `alsoTenEighty` constants themselves do not actually change. `tenEighty` and `alsoTenEighty` themselves do not “store” the `VideoMode` instance. Instead, they both refer to a `VideoMode` instance behind the scenes. It is the `frameRate` property of the underlying `VideoMode` that is changed, not the values of the constant references to that `VideoMode`.

### 6. Inheritance

In my opinion, there's a little too much fascination with inheritance. It is necessary to learn, but you spend more time simply modeling one thing than you do developing a hierarchy.

To get started, **encapsulation** is the more important concept to understand than inheritance is. Encapsulation in Swift in achieved with __Access Control__. 

Access control restricts access to parts of your code from code in other source files and modules. This feature enables you to hide the implementation details of your code, and to specify a preferred interface through which that code can be accessed and used.

#### Access Levels
Swift provides five different access levels for entities within your code. These access levels are relative to the source file in which an entity is defined.

|Access Level | Description |
| :-----: | -----: |
| Open | The highest (least restrictive) access level. Same as Public level except applies only to classes and class members.|
| Public | Enables entities to be used within any source file from their defining module, and also in a source file from another module that imports the defining module. You typically use open or public access when specifying the public interface to a framework.|
| Internal | Enables entities to be used within any source file from their defining module, but not in any source file outside of that module. You typically use internal access when defining an app’s or a framework’s internal structure. |
| Fileprivate | Restricts the use of an entity to its own defining source file. Use file-private access to hide the implementation details of a specific piece of functionality when those details are used within an entire file.|
| Private | Restricts the use of an entity to the enclosing declaration, and to extensions of that declaration that are in the same file. Use private access to hide the implementation details of a specific piece of functionality when those details are used only within a single declaration.|


You can define the access level for an entity by placing one of the `open`, `public`, `internal`, `fileprivate`, or `private` modifiers before the entity’s introducer:

```swift
public class SomePublicClass {}
internal class SomeInternalClass {}
fileprivate class SomeFilePrivateClass {}
private class SomePrivateClass {}
 
public var somePublicVariable = 0
internal let someInternalConstant = 0
fileprivate func someFilePrivateFunction() {}
private func somePrivateFunction() {}
```

Unless otherwise specified, the default access level is internal. This means that `SomeInternalClass` and `someInternalConstant` can be written without an explicit access-level modifier, and will still have an access level of internal:


```swift
class SomeInternalClass {}     // implicitly internal
let someInternalConstant = 0   // implicitly internal
```

### 7. Instance methods

Instance methods are functions that belong to instances of a particular class, structure, or enumeration. They support the functionality of those instances, either by providing ways to access and modify instance properties, or by providing functionality related to the instance’s purpose.

You write an instance method within the opening and closing braces of the type it belongs to. An instance method has implicit access to all other instance methods and properties of that type.

```swift
class Counter {

    var count = 0

    func increment() {
        count += 1
    }

    func increment(by amount: Int) {
        count += amount
    }

    func reset() {
        count = 0
    }
}
```

The `Counter` class declares a variable property, `count`, to keep track of the current counter value. In addition, it defines three instance methods:

* `increment()` increments the counter by 1.
* `increment(by: Int)` increments the counter by a specified integer amount.
* `reset()` resets the counter to zero.

An instance method can be called only on a specific instance of the type it belongs to. It cannot be called in isolation without an existing instance. You call instance methods with the same dot syntax as properties:

```swift
let counter = Counter()
// the initial counter value is 0
counter.increment()
// the counter's value is now 1
counter.increment(by: 5)
// the counter's value is now 6
counter.reset()
// the counter's value is now 0
```

#### The `self` Property
Every instance of a type has an implicit property called `self`, which is exactly equivalent to the instance itself. You use the `self` property to refer to the current instance within its own instance methods.

The `increment()` method in the example above could have been written like this:

```swift
func increment() {
    self.count += 1
}
```

In practice, if you don’t explicitly write `self`, Swift assumes that you are referring to a property or method of the current instance whenever you use a known property or method name within a method. __The main exception to this rule occurs when a parameter name for an instance method has the same name as a property of that instance.__ In this situation, the parameter name takes precedence, and it becomes necessary to refer to the property in a more qualified way. You use the `self` property to distinguish between the parameter name and the property name. 

Here, `self` disambiguates between a method parameter called `x` and an instance property that is also called `x`:

```swift
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}

let somePoint = Point(x: 4.0, y: 5.0)

if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}

// Prints "This point is to the right of the line where x == 1.0"
```

Without the `self` prefix, Swift would assume that both uses of `x` referred to the method parameter called `x`.

### 8. Type Methods

Type methods are methods that are called on the type itself. You indicate type methods by including the `static` keyword immediately before the method's `func` keyword. Type methods can be used in classes, structs, and enumerations. Classes may also use the `class` keyword to allow subclasses to override the superclass’s implementation of that method.


Type methods are called with dot syntax, like instance methods. However, you call type methods on the type, not on an instance of that type. Here’s how you call a type method on a class called `SomeClass`:

```swift
class SomeClass {

    class func someTypeMethod() {
        // type method implementation goes here
    }

}

SomeClass.someTypeMethod()
```

Within the body of a type method, the implicit `self` property refers to the type itself, rather than an instance of that type. This means that you can use `self` to disambiguate between type properties and type method parameters, just as you do for instance properties and instance method parameters.

---

### 9. Review and Wrapup

* Compare and contrast the use of ```struct``` and ```class```.
* What are type methods?

### 10. Project
Link to [AC-iOS-StructsClasses](https://github.com/C4Q/AC-iOS-StructsClasses) Project Instructions
 

