# Structs

---
### Objectives
* Understanding structs
* To create and initialize structs 
* Understand when to use a struct 
* Understand that structures are value types and what this implies


### Readings
1. [Swift Language Reference, Classes and Structures](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html#//apple_ref/doc/uid/TP40014097-CH13-ID82)
1. [Swift Language Reference, Methods](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Methods.html#//apple_ref/doc/uid/TP40014097-CH15-ID234)

#### Vocabulary
1. **Encapsulation** - means that objects keep their state information private.
1. **Initialization** - the process of preparing an instance of a class, structure, or enumeration for use by setting an initial value for each stored property on that instance.
1. **Instance** - a single and unique member of a class (or structure) that has specified values rather than variables, and represents an object. In a non-programming context, you could think of "dog" as a class and your particular pet dog as an instance of that class.
1. **Instantiation** - "Humans are born. Objects are instantiated. A baby is an instance of a Human, an object is an instance of some Class." [-More on Initialization vs Instantiation](https://stackoverflow.com/questions/2330767/what-is-the-difference-between-instantiated-and-initialized)
1. **Method** - a function that is associated with a class. _All methods are functions, but not all functions are methods._
1. **Object-Oriented Programming** - programming paradigm that represents the concept of “objects” that have properties (attributes that describe the object), and associated procedures/functions known as methods. [-WeHeartSwift](https://www.weheartswift.com/object-oriented-programming-swift/)
1. **Property** - a variable or constant value that is associated with a class.

---

### 1. Intro

What are the types that we've seen so far in Swift?

<details>
<summary>Types</summary>

- Int (and its family)
- Double
- Float
- String
- Character
- Array
- Dictionary
- Range
- Tuple
- Function types (e.g (String, Int) -> Void)
</details>

We saw that an Enum gives us more flexibility and customization.  But what if the Swift types we've seen so far is not sufficient for our custom application?   

We can create *custom* types!

By using Classes and Structs, we can define new types that can hold any information we want and can be manipulated as we choose.

We call Classes and Structs *Objects* and when programming with them, we talk about *Object Oriented Programming* (OOP).

**Structures and classes**
Structures and classes are general-purpose, flexible constructs that become the building blocks of your program’s code. You define properties and methods to add functionality to your structures and classes using the same syntax you use to define constants, variables, and functions.

### 2. Definition Syntax

structures have a similar definition syntax as classes. You introduce structures with the `struct` keyword. Both place their entire definition within a pair of braces.

```swift
struct SomeStructure {
    // structure definition goes here
}
```

##### Naming Conventions

From the Apple documentation:

> Whenever you define a new class or structure, you effectively define a brand new Swift type. Give types `UpperCamelCase` names (i.e. `SomeClass`, `SomeStructure`) to match the capitalization of standard Swift types (such as `String`, `Int`, and `Bool`). Conversely, always give properties and methods `lowerCamelCase` names (such as `frameRate` and `incrementCount`) to differentiate them from type names.


### 3. Stored Properties

Properties are constants and variables encapsulated inside structures.

> From Apple:

```swift
struct Resolution {
    var width = 0
    var height = 0
}
```

The keyword *struct* tells us that we are defining a new structure.  Resolution is the name of this struct.  We have defined a Resolution to have two *properties*, width and height.  Type inference sets these properties to Ints, and gives them both an initial value of 0.

### 4. Structs are Value Types

So far, all of the types we have seen so far are actually structures, and thus are value types. The following definition is directly from the Swift Standard Library.

```Swift
public struct Bool {

  ...

  public init(_ value: Bool) {
    self = value
  }
}
```

A structure is a *value type*.  This means that whenever you make a copy of structure, you copy the value that was held by it and create a new object.


```swift
var myBool = false
var myBoolCopy = myBool
myBool = true
print(myBoolCopy)
```

What will be printed to the console in the example above and why?

<details>
<summary>Answer</summary>

"false" will be printed to the console.  This is because we copied the **value** *false* and assigned a new object *myBoolCopy* to it.  It is not tied to the original that we copied it from.

</details>

We can see the same behavior in structures that we define ourselves:

```swift
struct Size {
  var width = 0.0
  var height = 0.0
}
var sampleSize = Size(width: 5.0, height: 10.0)
var sampleSizeCopy = sampleSize
sampleSize.width = 2.0
print(sampleSizeCopy.width)
```

What will be printed to the console in the example above and why?

<details>
<summary>Answer</summary>

"5.0" will be printed to the console.  This is because we copied the **value** *5.0* and assigned a new object * sampleSizeCopy* to it.  It is not tied to the original that we copied it from.

</details>

### 5. Creating Instances of Structs

The `Resolution` structure definition only describe what a `Resolution` will look like. They themselves do not describe a *specific* resolution. To do that, you need to create an instance of the structure. Structures use **initializer syntax** for new instances.

Where have you seen initialization syntax before?

<details>
<summary>Some examples</summary>

- `let emptyArr = [Int]()`
- `let emptyString = String()`
- `let zero = Int()`

</details>

#### Default Initializers
In a default initializer, the name of the type is followed by empty parentheses. You can use default initializers when your types either don’t have any stored properties, or when all of the type’s stored properties have default values. This holds true for both structures and classes.

Declaring an optional stored property as a constant (without an initial value) will inhibit you from using a default initializer.

Why does the following struct give you an error at compile-time?

```
struct IdentifyTheError {
	var propertyOne: String?
	let propertyTwo: String?
}

```

<details>
<summary>Solution</summary>

`propertyOne` is a variable, so the compiler can give it an initial value of `nil` and knows that you can change it to a `String` later.  `propertyTwo` is a constant.  The compiler could give it an initial value of `nil`, but then you couldn't change it later.  This would be kind of strange, so the compiler doesn't give it an initial value, and you need to supply your own.

</details>

#### Memberwise Initializers

Structs automatically get a memberwise initializer.  This allows you to give different values to the properties in an instance of your struct.

```swift
struct Size {
    var width = 0.0
    var height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0) //free memberwise initializer provided for all structs
```

#### Accessing Properties

You can access the properties of an instance using **dot syntax**. In dot syntax, you write the property name immediately after the instance name, separated by a period (.), without any spaces:

```swift
let losRes = Size(width: 256, height: 144)

print("The width of lowRes is \(lowRes.width)")
print("The height of lowRes is \(lowRes.height)")
```

Where have you used dot syntax to refer to a property before?

<details>
<summary>Examples</summary>

```swift
let myArr = [1,2,3]
print(myArr.count)

let myString = "Hello!"
print(myString.startIndex)
```

</details>


#### let vs var

We can define structs with properties that are either constant or variable.

```swift
struct User {
    let name: String
    var isLoggedIn: Bool
}

var userOne = User(name: "Adam", isLoggedIn: false)
userOne.isLoggedIn = true // Changes isLoggedIn to true
userOne.name = "Beth" //Compile error because name is a let constant
```

We can also assign structs to constants.  Because structs are value types, we can't change properties of a struct assigned to a let constant. 
```swift
struct User {
    let name: String
    var isLoggedIn: Bool
}

let userOne = User(name: "Adam", isLoggedIn: false)
userOne.isLoggedIn = true // Compile-time error: userOne is a let constant

```

### 6. Type Methods

Sometimes, we want to use methods on a class itself instead of on an instance of the class.  Take pi for an example.  

```swift
let radius = 5.0
let pi = 3.14159265358979
let circleArea = pi * radius * radius
```

We could write in the value of pi ourselves, but having to type it in every time would be annoying.  It would be great for that information to be stored somewhere that we could access easily.  And it is!

```swift
let radius = 5.0
let pi = Double.pi
let circleArea = pi * radius * radius
```

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

### 7. Mutating functions

What happens when we rewrite the Counter class as a struct?

```swift
struct Counter {
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

We notice we get some compiler errors.  They say:

>Left side of mutating operator isn't mutable: 'self' is immutable

We can see that we have marked the property count as a variable and not a constant, but we still getting an error.  Why?

Remember that structures are value types.  This means that when a user creates a structure, they expect that it will stay the same value.  If we want to change a property, we have to manually set it ourselves.  It also means that users of a structure will expect that using methods won't change the original information.  If we are breaking this expectation, we need to explicitly mark that in the function with the keyword *mutating*.  Mutating means "to change", so we are indicating this function will change *self*.  Let's update the struct to compile:

```swift
struct Counter {
    var count = 0

    mutating func increment() {
        count += 1
    }
    mutating func increment(by amount: Int) {
        count += amount
    }
    mutating func reset() {
        count = 0
    }
}
```

If you notice that you are having to mark a lot of things as mutating, it might be a good idea to use a class instead of a structure.


### 8. Review and Wrapup

* How can we create a struct definition?
* How can we create an instance of a struct?
* What are properties?
* What are instance methods?
* What are type methods?


### Standards

IOS: IOS.1, IOS.1.c

Language Fundamentals: LF.3
