### Structs & Classes
---

### Lesson Breakdown
[Structs Lesson](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/fundamentals/structs-and-classes/README1.md)

### Objectives
* Understand the differences between structs and classes
* To create and initialize structs and classes
* Understand when to use a struct vs a class
* Understand that structures are value types and what this implies
* Understand classes are reference types and what this implies

### Readings
1. [Swift Language Reference, Classes and Structures](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html#//apple_ref/doc/uid/TP40014097-CH13-ID82)
1. [Swift Language Reference, Methods](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Methods.html#//apple_ref/doc/uid/TP40014097-CH15-ID234)

#### Vocabulary
1. **Base Class** -  a class that does not inherit from another class.
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

Classes and structures have a similar definition syntax. You introduce classes with the `class` keyword and structures with the `struct` keyword. Both place their entire definition within a pair of braces.

```swift
class SomeClass {
    // class definition goes here
}

struct SomeStructure {
    // structure definition goes here
}
```

##### Naming Conventions

From the Apple documentation:

> Whenever you define a new class or structure, you effectively define a brand new Swift type. Give types `UpperCamelCase` names (i.e. `SomeClass`, `SomeStructure`) to match the capitalization of standard Swift types (such as `String`, `Int`, and `Bool`). Conversely, always give properties and methods `lowerCamelCase` names (such as `frameRate` and `incrementCount`) to differentiate them from type names.


### 3. Stored Properties

Properties are constants and variables encapsulated inside classes and structures.

> From Apple:

```swift
struct Resolution {
    var width = 0
    var height = 0
}
```

The keyword *struct* tells us that we are defining a new structure.  Resolution is the name of this struct.  We have defined a Resolution to have two *properties*, width and height.  Type inference sets these properties to Ints, and gives them both an initial value of 0.

```swift
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
```

The keyword *class* tells us that we are defining a new class named VideoMode.  It has four *properties* as shown below.

- resolution: Resolution
- interlaced: Bool
- frameRate: Double
- name: String?

### 4. Creating Instances of Structs & Classes

The `Resolution` structure definition and the `VideoMode` class definition only describe what a `Resolution` or `VideoMode` will look like. They themselves do not describe a *specific* resolution or video mode. To do that, you need to create an instance of the structure or class. Structures and classes both use **initializer syntax** for new instances.

We have already seen an initializer in the example above:

```
class VideoMode {
    var resolution = Resolution()
	...
```

Where have you seen this syntax before?

<details>
<summary>Some examples</summary>

- `let emptyArr = [Int]()`
- `let emptyString = String()`
- `let zero = Int()`

</details>

#### Default Initializers
In a default initializer, the name of the type is followed by empty parentheses. You can use default initializers when your types either don’t have any stored properties, or when all of the type’s stored properties have default values. This holds true for both structures and classes.

```swift
let someResolution = Resolution()
let someVideoMode = VideoMode()
```

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

#### Memberwise Initializers (for Structs only!)

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

We can also assign structs and classes to constants.  Because structs are value types, we can't change properties of a struct assigned to a let constant.  Because classes are reference types, we can change properties of a class assigned to a let constant.

```swift
struct User {
    let name: String
    var isLoggedIn: Bool
}

class Dog {
    let numberOfLegs: Int = 4
    var isSleepy: Bool = false
}

let userOne = User(name: "Adam", isLoggedIn: false)
userOne.isLoggedIn = true // Compile-time error: userOne is a let constant

let doggo = Dog()
doggo.isSleepy = true //No errors, doggo.isSleepy is now true
```

### 5. Instance methods

Instance methods are functions that belong to instances of a particular class, structure, or enumeration. We use instance methods to change a property of the object, or to generate a new piece of information.


What are some instance methods you are familiar with?

<details>
<summary>Some examples</summary>

- myArr.max()
- myArr.sort()
- myString.replacingInstances(of: " ", with: "")
- myDictionary.updateValue(0.310, forKey: "Derek Jeter")
</details>

Just like you are used to using instance methods for the structs we've seen so far, we can define instance methods for structs we write ourselves.

[From the Apple documentation](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Methods.html)

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

You call instance methods with the same dot syntax as properties:

```swift
let myCounter = Counter()
// the initial counter value is 0
myCounter.increment()
// the counter's value is now 1
myCounter.increment(by: 5)
// the counter's value is now 6
myCounter.reset()
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

In practice, if you don’t explicitly write `self`, Swift assumes that you are referring to a property or method of the current instance whenever you use a known property or method name within a method.


__The main exception to this rule occurs when a parameter name for an instance method has the same name as a property of that instance.__


Here, `self` makes the difference clear between a method parameter called `x` and an instance property that is also called `x`:

```swift
struct Point {
    var x = 0.0
    var y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}
```

Without the `self` prefix, Swift would assume that both uses of `x` referred to the method parameter called `x`.


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



### 7. Review and Wrapup

* How can we create a struct/class definition?
* How can we create an instance of a struct/class?
* What are properties?
* What are instance methods?
* What are type methods?


### Standards

IOS: IOS.1, IOS.1.c

Language Fundamentals: LF.3
