# Classes
---

### Objectives
* Understanding classes
* Understand when to use a class
* Understand classes are reference types and what this implies
* Use inheritance to create objects

### Readings
1. [Swift Language Reference, Classes and Structures](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html#//apple_ref/doc/uid/TP40014097-CH13-ID82)
1. [Swift Language Reference, Methods](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Methods.html#//apple_ref/doc/uid/TP40014097-CH15-ID234)

#### Vocabulary
1. **Base Class** -  a class that does not inherit from another class.
1. **Encapsulation** - means that objects keep their state information private.
1. **Inherit/Inheritance** - means that objects of one class can derive part of their behavior from a base or parent class.
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

Classes have a similar definition syntax as structures. You introduce classes with the `class` keyword Both place their entire definition within a pair of braces.

```swift
class SomeClass {
    // class definition goes here
}
```

##### Naming Conventions

From the Apple documentation:

> Whenever you define a new class or structure, you effectively define a brand new Swift type. Give types `UpperCamelCase` names (i.e. `SomeClass`, `SomeStructure`) to match the capitalization of standard Swift types (such as `String`, `Int`, and `Bool`). Conversely, always give properties and methods `lowerCamelCase` names (such as `frameRate` and `incrementCount`) to differentiate them from type names.


### 3. Stored Properties

Properties are constants and variables encapsulated inside classes.

> From Apple:

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




### 4. Creating Instances of Classes

The `VideoMode` class definition only describe what a `VideoMode` will look like. They themselves do not describe a *specific* video mode. To do that, you need to create an instance of the class. Classes use **initializer syntax** for new instances.

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

#### let vs var

We can define classes with properties that are either constant or variable because classes are reference types, we can change properties of a class assigned to a let constant.

```swift
class Dog {
    let numberOfLegs: Int = 4
    var isSleepy: Bool = false
}

let doggo = Dog()
doggo.isSleepy = true //No errors, doggo.isSleepy is now true
```


### 5. Classes are Reference Types


Unlike value types, reference types are not copied when they are assigned to a variable or constant, or when they are passed to a function. Rather than a copy, a reference to the same existing instance is used instead.

Let's take a look at an example using our class from above:

```swift
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
```


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


The following visual can serve as a quick reference to summarize the difference between passing by value (making a copy) and passing by reference (making another object that points to the same place)

![Pass by Reference vs. Pass by value](https://blog.penjee.com/wp-content/uploads/2015/02/pass-by-reference-vs-pass-by-value-animation.gif)

---


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



### 6. Inheritance

A class can inherit methods, properties, and other characteristics from another class. When one class inherits from another, the inheriting class is known as a __subclass__, and the class it inherits from is known as its __superclass__.

Classes in Swift can call and access methods, properties, and subscripts belonging to their superclass and can provide their own overriding versions of those methods, properties, and subscripts to refine or modify their behavior.

#### Defining a Base Class

Any class that does not inherit from another class is known as a base class. Swift classes do not inherit from a universal base class. Classes you define without specifying a superclass automatically become base classes for you to build upon.

```swift
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // do nothing - an arbitrary vehicle doesn't necessarily make a noise
    }
}
```

The code above defines a base class called `Vehicle`.

#### Subclassing

Subclassing is the act of basing a new class on an existing class. The subclass inherits characteristics from the existing class, which you can then refine. You can also add new characteristics to the subclass.

To indicate that a subclass has a superclass, write the subclass name before the superclass name, separated by a colon:

__General Syntax:__
```swift
class SomeSubclass: SomeSuperclass {
    // subclass definition goes here
}
```

Let's subclass our base class `Vehicle`:

```swift
class Bicycle: Vehicle {
    var hasBasket = false
}
```

The new `Bicycle` class automatically gains all of the characteristics of `Vehicle`, such as its `currentSpeed` and `description` properties and its `makeNoise()` method.

In addition to the characteristics it inherits, the `Bicycle` class defines a new stored property, `hasBasket`, with a default value of false. You can also modify the inherited currentSpeed property of a Bicycle instance, and query the instance’s inherited description property:

```swift
let bicycle = Bicycle()

bicycle.hasBasket = true
bicycle.currentSpeed = 15.0

print("Bicycle: \(bicycle.description)")
// Bicycle: traveling at 15.0 miles per hour
```

Subclasses can themselves be subclassed. The next example creates a subclass of `Bicycle` for a two-seater bicycle known as a `Tandem`:

```swift
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}
```

#### Overriding

A subclass can provide its own custom implementation of an instance method, type method, instance property, type property, or subscript that it would otherwise inherit from a superclass. This is known as overriding.

To override a characteristic that would otherwise be inherited, you prefix your overriding definition with the `override` keyword. Doing so clarifies that you intend to provide an override and have not provided a matching definition by mistake.

The `override` keyword also prompts the Swift compiler to check that your overriding class’s superclass (or one of its parents) has a declaration that matches the one you provided for the override. This check ensures that your overriding definition is correct.

__Overriding Methods__

You can override an inherited instance or type method to provide a tailored or alternative implementation of the method within your subclass.

The following example defines a new subclass of `Vehicle` called `Train`, which overrides the `makeNoise()` method that `Train` inherits from `Vehicle`:

```swift
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}

let train = Train()
train.makeNoise()
// Prints "Choo Choo"
```

When you create a new instance of `Train` and call its `makeNoise()` method, you can see that the `Train` subclass version of the method is called.

### 7. Computed Properties

Computed properties do not actually store a value. They actually _compute_ a value by providing a __getter__, and an optional __setter__, to retrieve and set other properties and values indirectly (rather than storing values directly).

While stored properties are provided by classes and structures only, computed properties are provided by classes, structures, and enumerations.

#### ```get``` and ```set```

__Syntax:__

```swift
//within a class or structure

var variableName: dataType {
    get {
        //code to execute
        return someValue
    }
    set(newValue) {
        //code to execute
    }
}
```


Because computed properties do not actually store values, the value from the getter (marked with the `get` keyword) is meant to be computed from other instance properties.

If a computed property’s setter does not define a name for the new value to be set, a default name of `newValue` is used.

__Example:__

```swift
class Bird {
    var wingLength: Int
    var wingSpan: Int {
        get {
            // This computed property is based on wingLength.
            return wingLength * 2
        }
        set {
            // Store the results of a computation.
            wingLength = newValue / 2
        }
    }
    init() {
        self.wingLength = 0
    }
}

var parrot = Bird()
// We write and read the results of the computed properties.
parrot.wingSpan = 2
print(parrot.wingSpan)
```

In the example above, when the `wingSpan` computed property was accessed using dot syntax, the value passed (2) was captured by `newValue`. In the setter, `newValue` was divided by two, and the result was captured by `wingLength`. Once `wingLength` was set to the result of that computation, it was then used to calculate `wingSpan` in the getter.

#### Read-Only Computed Properties
A computed property with a getter, but no setter is known as a _read-only computed property_.

A read-only computed property always returns a value, and can be accessed through dot syntax, but cannot be set to a different value.

Consider our ```President``` object. We can add a simple read-only computed property to get the number of years the president served. This makes for a more direct and consistent interface as compared to having the user compute it, or even having to call a method. It also helps us avoid storing redundant data (which is an error prone practice).

```swift
var yearsInOffice: Int {
    get {
        return yearLeftOffice - yearEnteredOffice
    }
}

let io = georgeWashington.yearsInOffice
```

__Note:__ The `get` keyword can be omitted when no `set` is present. The `get` is assumed by the Swift compiler:

```swift
//Equivalent to snippet above
var yearsInOffice: Int {
    return yearLeftOffice - yearEnteredOffice
}
```

By using a setter, we can affect the backing variables.

```swift
    var yearsInOffice: Int {
        get {
            return yearLeftOffice - yearEnteredOffice
        }
        set(newValue) {
            yearLeftOffice = yearEnteredOffice + newValue
        }
    }
```

Computed properties, including read-only properties must be stored as variables, not constants.



### 8. Review and Wrapup

* How can we create a struct/class definition?
* How can we create an instance of a struct/class?
* What are properties?
* What are instance methods?
* What are type methods?



### 1. Comparing Classes and Structures

We've reviewed how to create classes and structs, but what's the difference between them?  Why would we want to make a class instead of a struct?

### Standards

IOS: IOS.1, IOS.1.c

Language Fundamentals: LF.3
