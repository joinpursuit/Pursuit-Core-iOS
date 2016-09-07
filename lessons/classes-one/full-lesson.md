# Standards
Solve problems with Enumerations, Structures and Classes

# Objectives
Students will be able to:
properties methods and initialation
* Create and use stored properties
* Create and use computed properties

# Resources
Swift Programming: The Big Nerd Ranch Guide, Chapter 16, Properties

Apple's [Swift Language Reference, Properties](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Properties.html#//apple_ref/doc/uid/TP40014097-CH14-ID254)

And [Swift Language Reference, Inheritance](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Inheritance.html#//apple_ref/doc/uid/TP40014097-CH17-ID193)

# Assessment Materials
## Midday Check-in and solutions

- Exercises and solutions (add links)
- Homework and solutions (add links)

## Warm up
TODO: Some logic warmups like the end of the previous lesson

# Lecture

## Properties

### Basic Stored Properties

No surprises here.

### Nested Types

Look at the ```Genre``` enum in our Movie app. Shouldn't that go under Movie?

### Lazy Stored Properties

An optimization we're not going to spend any time implementing now. Just know what they are
used for and why. They are used to postpone the actual execution of a block of code until the first time
the property is needed. The why depends on the situation but is usually either because we want 
to create an instance of the object in question before something external is ready: think network
or other resource. Or because the work of fulling instantiating the property is expensive and there's 
a good enough chance we may never need to do it. Hence lazy (in the good sense).

### Computed Properties

#### ```get``` and ```set```

Consider our ```President``` object. We can add a simple computed property to get the 
number of years the president served. This makes for a more direct and consistent interface
as compared to having the user compute it or even call a method. It also helps us avoid 
storing redundant data which is error prone.

```swift
var yearsInOffice: Int {
    get {
        return yearLeftOffice - yearEnteredOffice
    }
}

let io = georgeWashington.yearsInOffice
```

Setting a *getter* alone makes the property read-only.

With a setter we can affect the backing variables. 

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

> **Exercise**
>
> Write a computed property ``castString``` on Movie that prints the list of actors
> separated by commas, as we did earlier. It only needs a getter. Challenge: write a 
> setter that takes a string.

### Type Properties

Type properties are accessible without an instance of the class.

Mark ordinary properties with the keyword ```static```.

```swift
static var oath = "I do solemnly swear (or affirm) that I will faithfully execute the Office of President of the United States, and will to the best of my ability, preserve, protect and defend the Constitution of the United States."

President.oath
```

Computed properties can be overridden and are marked with the keyword ```class```

```swift
class var personalStatement: String {
    get {
        return "I am a human being!"
    }
}
```
> **Exercise**

> Override personal statement in Actor to say something actorly, in a general way.

### Access Control

We'll work with this more in the future.


# Review and Wrapup

* Compare and contrast the use of stored and computed properties.
* What are getters and setters?
* Why use access control?
