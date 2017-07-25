### Properties
---

### Objectives
* To understand properties, methods, and initialization
* Create and use stored properties
* Create and use computed properties

### Readings
1. Swift Programming: The Big Nerd Ranch Guide, Chapter 16, Properties
1. [Swift Language Reference, Properties](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Properties.html#//apple_ref/doc/uid/TP40014097-CH14-ID254)
1. [Swift Language Reference, Inheritance](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Inheritance.html#//apple_ref/doc/uid/TP40014097-CH17-ID193)

---

### 1. Intro to Properties

Properties associate values with a particular class, structure, or enumeration. There are stored and computed properties, which are usually associated with an instance of a type. And then, there are type properties, which are associated with the type itself.  

### 2. Stored Properties

A stored property is a constant or variable that is stored as part of an instance of a particular class, or structure. Stored properties are only provided by classes and stuctures (not enums). 

Variable stored properties are introduced with the `var` keyword, while constant stored properties are introduced with the `let` keyword. 

You can provide a default value for the stored property as a part of its definition, or you can set and modify the initial value for a stored property during initialization. Once a constant stored property has been given an initial value, it's value can no longer be changed.

#### Stored Properties of Constant Structure Instances

If you create an instance of a stucture, and assign that instance to a constant, you cannot modify the stucture's properties even if those properties were declared as variables. This behavior is due to stuctures being value types. 

The same cannot be said of classes because they are reference types. If you assign an instance of a reference type to a constant, you are still able to change that instance's variable properties. 

### 3. Lazy Stored Properties

An optimization we're not going to spend any time implementing now. Just know what they are used for and why. 

A lazy stored property is a property whose initial value is not calcualted until the first time the property is needed. Reasons to use lazy stored propeties depends on the situation. We usually use them either because we want to create an instance of the object in question before something external is ready (think network or other resource), or because the work of fully instantiating the property is expensive and there's a good enough chance we may never need to do it. Hence lazy (in the good sense). 

To make a stored property lazy, simply add the `lazy` keyword in front of your stored property definition.

### 4. Computed Properties

Computed properties do not actually store a value. They actually _compute_ a value by providing a __getter__, and an optional __setter__, to retrieve and set other properties and values indirectly (rather than storing values directly).

While stored properties are provided by classes and structures only, computed properties are provided by classes, structures, and enumerations.



#### ```get``` and ```set```

>INSERT - info/definitions on getters & setters - HERE

#### Read-Only Computed Properties
A computed property with a getter, but no setter is known as a _read-only computed property_. 

A read-only computed property always returns a value, and can be accessed through dot syntax, but cannot be set to a different value.

Consider our ```President``` object. We can add a simple read-only computed property to get the number of years the president served. This makes for a more direct and consistent interface as compared to having the user compute it or even call a method. It also helps us avoid storing redundant data which is error prone.

```swift
var yearsInOffice: Int {
    get {
        return yearLeftOffice - yearEnteredOffice
    }
}

let io = georgeWashington.yearsInOffice
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

> **Exercise**
>
> Write a computed property `castString` on Movie that prints the list of actors separated by commas, as we did earlier. It only needs a getter. 
>
>__Challenge:__ Write a setter that takes a string.

One last, but important thing, to note about computed properties is that they cannot be stored as variables with the `var` keyword. Even a read-only computed property cannot be written as a constant.

### 5. Type Properties

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

### ?. Nested Types

Look at the ```Genre``` enum in our Movie app. Shouldn't that go under Movie?


# Review and Wrapup

* Compare and contrast the use of stored and computed properties.
* What are getters and setters?
* Why use access control?
