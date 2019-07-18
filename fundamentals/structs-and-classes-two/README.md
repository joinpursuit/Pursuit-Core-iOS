### Structs & Classes 2
---

### Objectives
* Understand the differences between structs and classes
* Understand when to use a struct vs a class
* Understand that structures are value types and what this implies
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



### 1. Comparing Classes and Structures

We've reviewed how to create classes and structs, but what's the difference between them?  Why would we want to make a class instead of a struct?


### 2. Structs are Value Types

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


### 3. Classes are Reference Types


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

### 4. Mutating functions

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


### 5. Inheritance

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

### 6. Computed Properties

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
