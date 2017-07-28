### Initialization

---

### Objectives
* Understand and use initialization 
* Understand and use inheritance 

### Readings
1. Swift Programming: The Big Nerd Ranch Guide, Chapter 17, Initialization
1. [Swift Language Reference, Initialization](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID203)

#### Vocabulary

1. __Initialization__ - the process of preparing an instance of a class, structure, or enumeration for use.
1. __Initializer__ - special methods that can be called to create a new instance of a particular type.

---

### 1. Intro to Initialization

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

Since subclasses depend on the superclass's initializers a change to the parent's initializers must be carried through. 

__Exercise__
Complete [Part 1 of AC-iOS-Initialization](https://github.com/C4Q/AC-iOS-Initialization)


#### Convenience Initializers
Convenience initializers let you have simpler initializers that just call through to a designated initializer.

__Exercise__
Complete [Part 2 of AC-iOS-Initialization](https://github.com/C4Q/AC-iOS-Initialization)


#### Failable Initalizers 

Initializers can fail. It's more likely you'll be using these initializers (you certainly will be) than you'll be writing them. They follow the general rule of optionals.

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

### 3. Struct Initialization 

Not going to look at this now. We'll define classes mostly and any struct you create you can initialize with the default initializer. 
