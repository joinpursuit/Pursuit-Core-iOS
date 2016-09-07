# Standards
Solve problems with Enumerations, Structures and Classes

# Objectives
Students will be able to:
* Understand and use initialization 
* Understand and use inheritance 

# Resources
Swift Programming: The Big Nerd Ranch Guide, Chapter 17, Initialization

Apple's [Swift Language Reference, Initialization](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID203)

# Lecture

## Initialization

### ```struct``` Initialization 

Not going to look at this now. We'll define classes mostly and any struct you create you can
initialize with the default initializer. 

### Class Initialization

Adding inits allow us to build more realistic objects than the ones we made prior to this with
default values. Swift goes to great lengths to enforce the creation of valid objects.

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

> **Exercise**
> Give Actor a designated initializer. Don't forget to call super.init.

#### Default initializers for ```class```

A class will get a default initializer when there are default values and no initializer is 
defined.

#### Initialization and ```class``` inheritance

Since subclasses depend on the superclass's initializers a change to the parent's initializers
must be carried through. This was illustrated in the book by introducing an ```init``` that made the
free initializer unavailable.

#### Designated initializers

```swift
init(name: String, born: Int, died: Int?) {
    self.name = name
    self.yearBorn = born
    self.yearDied = died
}
```
Designated initializers are identified by the **lack** of the ```convenience``` keyword.

#### Convenience initializers for ```class```

> **Exercise**

1. Give President a convenience initializer that takes a start year and a number of terms served. 
1. Give President a convenience initializer that takes a start year and a number of years served. 
1. Give President a convenience initializer that takes a year elected (year before start) and a number of terms served. 


#### Required initializers for ```class```

This is a class design paradigm that we won't look at now.

#### Deinitialization

Deinitialization is not as important as the same construct in other languages where memory management
is more hands on. There may be other resources associated with an object going out of scope. 

```swift
deinit {
	print("Goodbye Mr. President (\(name))")
}
```

### Failable Initalizers 

Initializers can fail. It's more likely you'll be using these initializers (you certainly will be)
than you'll be writing them. They follow the general rule of optionals.

## Exercise

Finish and fix the movie app to use realistic initializers.

