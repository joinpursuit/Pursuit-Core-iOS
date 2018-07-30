### Structs & Classes
---

Note: include property observers (pending space)

### Objectives
* Understand the differences between structs and classes
* To create and initialize structs and classes
* Understand when to use a struct vs a class
* Understand that structures are value types and what this implies

### Readings
1. Swift Programming: The Big Nerd Ranch Guide, Chapter 15, Structs and Classes
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

We saw yesterday that an Enum gives us more flexibility and customization.  But what if the Swift types we've seen so far don't do what we need them to?  

We can make *new* types that do whatever we want!

By using Classes and Structs, we can define new types that can hold any information we want and can be manipulated as we choose.

We call Classes and Structs *Objects* and when programming with them, we talk about *Object Oriented Programming* (OOP).

From the Apple documentation:

> An instance of a class is traditionally known as an object. However, Swift classes and structures are much closer in functionality than in other languages, and much of this chapter describes functionality that can apply to instances of either a class or a structure type. Because of this, the more general term instance is used.


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

```
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

The `Resolution` structure definition and the `VideoMode` class definition only describe what a `Resolution` or `VideoMode` will look like. They themselves do not describe a specific resolution or video mode. To do that, you need to create an instance of the structure or class. Structures and classes both use **initializer syntax** for new instances.

We have already seen an initializer in the example above:

```
class VideoMode {
    var resolution = Resolution()
	...
```

Where have you seen this syntax before?

<details>
<summary>Some examples</summary>

- let emptyString = String()
- let zero = Int()
- let emptyArr = Array\<Int\>()

</details>

#### Default Initializers 
In a default initializer, the name of the type is followed by empty parentheses. You can use default initializers when your types either don’t have any stored properties, or when all of the type’s stored properties have default values. This holds true for both structures and classes.

```swift
let someResolution = Resolution()
let someVideoMode = VideoMode()
```

Declaring an optional stored property as a constant (without an intial value) will inhibit you from using a default initializer.

Why does the following struct give you an error at compile-time?

```
struct IdentifyTheError {
	var propertyOne: String?
	let propertyTwo: String?
}

```

<details>
<summary>Solution</summary>

Declaring your optional properties as variables still enables us to use a default initializer, even if that variable optional has not been given an initial value. The reason for that is because the value contained in a variable can be changed at any point after their initialization, while a constant can never be changed. So, an optional that is declared as a constant with no inital value can never be given a value at any other point. Remember, when you are creating an instance of a new type, all of its properties must be properly initialized.

</details>

#### Memberwise Initializers (for Structs only!)

Structure types automatically receive a memberwise initializer if they do not define any of their own custom initializers. Unlike a default initializer, the structure receives a memberwise initializer even if it has stored properties that do not have default values.

The memberwise initializer is a shorthand way to initialize the member properties of new structure instances. Initial values for the properties of the new instance can be passed to the memberwise initializer by name.

```swift
struct Size {
    var width = 0.0
    var height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0) //free memberwise initializer provided for all structs
```

##### Preview for next lesson

Note that if you define a custom initializer for a value type, you will no longer have access to the default initializer (or the memberwise initializer, if it is a structure) for that type. 

>If you do want your custom value type to be initializable with the default initializer and memberwise initializer, and also with your own custom initializers, write your custom initializers in an extension rather than as part of the value type’s original implementation.

#### Accessing Properties

You can access the properties of an instance using **dot syntax**. In dot syntax, you write the property name immediately after the instance name, separated by a period (.), without any spaces:

```swift
print("The width of someResolution is \(someResolution.width)")
print("The width of lowRes is \(lowRes.width)")
```



### 5. Comparing Classes and Structures

We've reviewed how to create classes and structs, but what's the difference between them?  Why would we want to make a class instead of a struct?  They both can do the following:

* Define properties to store values
* Define methods to provide functionality
* Define initializers to set up their initial state

Here are some of the key differences:

|Classes|Structs|
|---|---|
|Supports inheritence| Does not support inheritence|
|Reference Types| Value Types|


##### Preview for the coming weeks


For future reference, here is the passage from the Apple documentation.  We will encounter all of these terms over the next few weeks.


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



### 5. Structs are Value Types

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


### 6. Classes are Reference Types



Unlike value types, reference types are not copied when they are assigned to a variable or constant, or when they are passed to a function. Rather than a copy, a reference to the same existing instance is used instead.

Let's take a look at an exmaple using our class from above:

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

### 7. Instance methods

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


### 8. Mutating functions

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

### 9. Type Methods

Sometimes, we want to use methods on a class itself instead of on an instance of the class.  Take pi for an example.  

let radius = 5.0
let pi = ?
let circleArea = pi * radius * radius

We could write in the value of pi ourselves, but 

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


### 10. Inheritance

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

---

### 11. Review and Wrapup

* Compare and contrast the use of ```struct``` and ```class```.
* What are type methods?

### 12. Project
Link to [AC-iOS-StructsClasses](https://github.com/C4Q/AC-iOS-StructsClasses) Project Instructions
 

