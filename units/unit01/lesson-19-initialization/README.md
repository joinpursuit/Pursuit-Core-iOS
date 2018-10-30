### Initialization

---

### Objectives
* Understand and use initialization 
* Understand and use inheritance 

### Readings
1. [Swift Language Reference, Initialization](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID203)

#### Vocabulary

1. __Initialization__ - the process of preparing an instance of a class, structure, or enumeration for use.
1. __Initializer__ - special methods that can be called to create a new instance of a particular type.

---


### 1. Type Methods

Sometimes, we want to use methods on a class itself instead of on an instance of the class. Take pi for an example.

let radius = 5.0 let pi = ? let circleArea = pi * radius * radius

We could write in the value of pi ourselves, but

Type methods are methods that are called on the type itself. You indicate type methods by including the static keyword immediately before the method's func keyword. Type methods can be used in classes, structs, and enumerations. Classes may also use the class keyword to allow subclasses to override the superclass’s implementation of that method.

Type methods are called with dot syntax, like instance methods. However, you call type methods on the type, not on an instance of that type. Here’s how you call a type method on a class called SomeClass:

class SomeClass {

    class func someTypeMethod() {
        // type method implementation goes here
    }

}

SomeClass.someTypeMethod()
Within the body of a type method, the implicit self property refers to the type itself, rather than an instance of that type. This means that you can use self to disambiguate between type properties and type method parameters, just as you do for instance properties and instance method parameters.





### 1. Initialization

The process of initialization involves setting an initial value for each stored property on that instance and performing any other setup or initialization that is required before the new instance is ready for use.

Classes and structures must set all of their stored properties to an appropriate initial value by the time an instance of that class or structure is created. Stored properties cannot be left in an indeterminate state.

__You implement the initialization process by defining initializers.__ Unlike Objective-C initializers, Swift initializers do not return a value. Their primary role is to ensure that new instances of a type are correctly initialized before they are used for the first time.

You can set an initial value for a stored property within an initializer, or by assigning a default property value as part of the property’s definition: 

#### Setting Default Initial Values for Stored Properties

In its simplest form, an initializer is like an instance method with no parameters, written using the init keyword:

```swift
init() {
    // perform some initialization here
}
```

```swift
class Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")
// Prints "The default temperature is 32.0° Fahrenheit"
```

As previously stated, you can set the initial value of a stored property from within an initializer, as shown above. 

Alternatively, you can specify a default property value as part of the property’s declaration. You specify a default property value by assigning an initial value to the property when it is defined:

```swift
class Fahrenheit {
    var temperature = 32.0
}
```

#### Default Initializers

A class, or struct, will get a default initializer when there are default values and no initializer is defined. The default initializer simply creates a new instance with all of its properties set to their default values.

```swift
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()
```

As you will see below, you can customize the initialization process with input parameters and optional property types, or by assigning constant properties during initialization.

---

### 2. Class Initialization

Adding inits allow us to build more realistic objects than the ones we made prior to this with default values. Swift goes to great lengths to enforce the creation of valid objects.

All of a class’s stored properties—including any properties the class inherits from its superclass—must be assigned an initial value during initialization.

Swift defines two kinds of initializers for class types to help ensure all stored properties receive an initial value. These are known as designated initializers and convenience initializers.

#### Designated initializers

Designated initializers are the primary initializers for a class. A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain. __Every class must have at least one designated initializer__.

Designated initializers for classes are written in the same way as simple initializers for value types:

```swift
class Person {
    var name: String
    var yearBorn: Int
    var yearDied: Int?
    
    init(name: String, born: Int, died: Int?) {
        self.name = name
        self.yearBorn = born
        self.yearDied = died
    }
}
```

Designated initializers are identified by the **lack** of the ```convenience``` keyword.


#### Initialization and Class Inheritance: `super.init()`

Subclasses are also able to use the initializers from their superclasses, with one key difference.


From the apple docs:

>If your subclass doesn’t define any designated initializers, it
>automatically inherits all of its superclass designated
>initializers.

This means that until you definie your own initializers, you get the initialzers from your superclass.

```swift
class Musician: Person {
	func describeMusician() {
		print("(self.name) is a musician who was born in \(yearBorn)"
	}
}
```

```swift
let ringo = Musician(name: "Ringo Starr", born: 1940, died: nil)
ringo.describeMusician()
```

However, if want our Musician class to store more information, we'll need to create our own initializer.


```swift
class Musician: Person {
    var instrument: String
    init(name: String, born: Int, died: Int?, instrument: String) {
        self.instrument = instrument
        super.init(name: name, born: born, died: died)
    }
}

```

We notice a new keyword above: ```super```.  This refers to the superclass that we are inheriting from.  Whenever we initialize a subclass, we always need to call ```super.init``` to make sure that we are initializing all the properties that our class has.  The compiler will give an error if you do not call ```super.init``` because it needs to make sure that all of the properties have a value of the appropriate type.


__Exercise__
Complete [Part 1 of AC-iOS-Initialization](https://github.com/C4Q/AC-iOS-Initialization)




#### Convenience Initializers
Convenience initializers let you have simpler initializers that just call through to a designated initializer. They are secondary, supporting initializers for a class.

You can define a convenience initializer to:

* Call a designated initializer from the same class as the convenience initializer with some of the designated initializer’s parameters set to default values 
* Create an instance of that class for a specific use case or input value type.

Convenience initializers are written in the same style as designated initializers, but with the `convenience` modifier placed before the `init` keyword, separated by a space:

```swift
convenience init(parameters) {
    //statements
}
```

You do not have to provide convenience initializers if your class does not require them. Creating convenience initializers whenever a shortcut to a common initialization pattern will save time or make initialization of the class clearer in intent.

Let's take a look at an example:

```swift
class TwoDPoint {
    var x: Double
    var y: Double
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    convenience init() {
        self.init(x: 0, y: 0)
    }
    convenience init(x: Double) {
        self.init(x: x, y: 0)
    }
    convenience init(y: Double) {
        self.init(x: 0, y: y)
    }
}
```

Here, we define a class TwoDPoint.  It has an x and a y and a designated initializer that sets both properties.

It has three convience initializers.  What they do in effect is assign any properties to 0 that the user doesn't set themselves.   We can see that they each call ```self.init```, because every convience initializer must call a designated initializer at some point to ensure that all properties are given an initial value.  

Convenience initializers become even more interesting when we look at inheritence.  Below, we will create a 3-d point.

```swift
class ThreeDPoint: TwoDPoint {
    var z: Double
    init(x: Double, y: Double, z: Double) {
        self.z = z
        super.init(x: x, y: y)
    }
}
```

Try to create a ThreeDPoint.  What initializers are available?

```
let myPoint = ThreeDPoint(
```

We see that we don't get any of the convenience initializers from above.  This makes sense, because the compiler wouldn't know what to do with our new 	```z``` property.  Let's look at a way of getting access to those initializers by redefining our ThreeDPoint:

```swift
class ThreeDPoint: TwoDPoint {
    var z: Double
    init(x: Double, y: Double, z: Double) {
        self.z = z
        super.init(x: x, y: y)
    }
    convenience override init(x: Double, y: Double) {
        self.init(x: x, y: y, z: 0)
    }
}
```

Here, we now have an initializer that has the same parameters ass the TwoDPoint designated initializer.  That's why we need to mark it ```override```.  We mark it ```convenience``` because it doesn't set all the properties of ThreeDPoint itself; it needs to call ```self.init```.  Let's look at what initializers we have now when we make a ThreeDPoint.

```swift
let otherPoint = ThreeDPoint(
```

Using convenience initializers, we are able to save time and give more options for creating an instance of class.

Taken from the documentation:


>If your subclass provides an implementation of all of its
>superclass designated initializers—either by inheriting them as
>per rule 1, or by providing a custom implementation as part of
>its definition—then it automatically inherits all of the
>superclass convenience initializers.





__Exercise__
Complete [Part 2 of AC-iOS-Initialization](https://github.com/C4Q/AC-iOS-Initialization)



#### Summary of intializers

The Swift documentation provides three rules for keeping track of initializers.

#### Rule 1
A designated initializer must call a designated initializer from its immediate superclass.

#### Rule 2
A convenience initializer must call another initializer from the same class.

#### Rule 3
A convenience initializer must ultimately call a designated initializer.

A simple way to remember this is:

Designated initializers must always delegate up.
Convenience initializers must always delegate across.

The following image helps illustrate this:

![image](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/initializerDelegation01_2x.png)



### Failable Initalizers 

It is sometimes useful to define a class, structure, or enumeration for which initialization can fail. This failure might be triggered by invalid initialization parameter values, the absence of a required external resource, or some other condition that prevents initialization from succeeding. 

To cope with initialization conditions that can fail, define one or more failable initializers as part of a class, structure, or enumeration definition. You write a failable initializer by placing a question mark after the init keyword (`init?`). 

A failable initializer creates an optional value of the type it initializes. You write `return nil` within a failable initializer to indicate a point at which initialization failure can be triggered.

>Strictly speaking, initializers do not return a value. Rather, their role is to ensure that self is fully and correctly initialized by the time that initialization ends. Although you write return nil to trigger an initialization failure, you do not use the return keyword to indicate initialization success.


Any initializers can be marked as failable by putting a question mark after the word init.

```swift
class Animal {
    var numberOfLegs: Int
    init?(numberOfLegs: Int) {
        guard numberOfLegs > -1 else {
            return nil
        }
        self.numberOfLegs = numberOfLegs
    }
}
```

Because an animal can't have a negative number of legs, we return nil if that's what was passed into the initializer.

We have actually seen a failable initializer already.  Where has it come up?


<details>
<summary> Solution </summary>
Creating an enum from a raw value
</details>

__Exercise__
Complete [Part 3 of AC-iOS-Initialization](https://github.com/C4Q/AC-iOS-Initialization)

#### Deinitialization

Deinitialization is not as important as the same construct in other languages where memory management is more hands on. There may be other resources associated with an object going out of scope. 

```swift
deinit {
    print("Goodbye Mr. President (\(name))")
}
```

---

### 3. Initialization for structs and enums

Much less frequently, we can define initializers for our structs and enums that we create.  

#### Structs

We can initialize a struct most commonly by the memberwise initializer we get by default.

```
enum GameState {
    case inProgress, victory, defeat
}

struct GameBrain {
    var maxNumberOfGuesses: Int = 3
    var correctNum: Int
    var currentNumberOfGuesses = 0
    mutating func guess(number: Int) -> GameState {
        currentNumberOfGuesses += 1
        if number == correctNum {
            return .victory
        }
        if currentNumberOfGuesses >= maxNumberOfGuesses {
            return .defeat
        }
        return .inProgress
    }
}

var game = GameBrain(maxNumberOfGuesses: 10, correctNum: 5, currentNumberOfGuesses: 0)

```

Because it's a little awkward to have to give the currentNumberOfGuesses and maxNumberOfGuesses ourselves, we can definite an initializer:

```
struct GameBrain {
    var maxNumberOfGuesses: Int = 3
    var correctNum: Int
    var currentNumberOfGuesses = 0
    init(correctNum: Int) {
    	self.maxNumberOfGuesses = 3
    	self.currentNumberOfGusses = 0
    	self.correctNum = correctNum
    }
    mutating func guess(number: Int) -> GameState {
        currentNumberOfGuesses += 1
        if number == correctNum {
            return .victory
        }
        if currentNumberOfGuesses >= maxNumberOfGuesses {
            return .defeat
        }
        return .inProgress
    }
}
```

These are simpler than for classes, because structs and enums do not support inheritence.

For enums, we don't have anything saved except what self is, so we set that in our initializer.


```
enum Color {
    case blue, green, red, error
    init(c: Character) {
        switch String(c).lowercased() {
        case "b":
            self = .blue
        case "g":
            self = .green
        case "r":
            self = .red
        default:
            self = .error
        }
    }
}

let myColor = Color(c: "b")
```

