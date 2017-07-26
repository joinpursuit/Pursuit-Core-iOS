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

```swift
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// the range represents integer values 0, 1, and 2

rangeOfThreeItems.firstValue = 6
// the range now represents integer values 6, 7, and 8
```

#### Stored Properties of Constant Structure Instances

If you create an instance of a stucture, and assign that instance to a constant, you cannot modify the stucture's properties even if those properties were declared as variables. This behavior is due to stuctures being value types. 

```swift
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
// this range represents integer values 0, 1, 2, and 3

rangeOfFourItems.firstValue = 6
// this will report an error, even though firstValue is a variable property
```

The same cannot be said of classes because they are reference types. If you assign an instance of a reference type to a constant, you are still able to change that instance's variable properties. 

### 3. Lazy Stored Properties

An optimization we're not going to spend any time implementing now. Just know what they are used for and why. 

A lazy stored property is a property whose initial value is not calcualted until the first time the property is needed. Reasons to use lazy stored propeties depends on the situation. We usually use them either because we want to create an instance of the object in question before something external is ready (think network or other resource), or because the work of fully instantiating the property is expensive and there's a good enough chance we may never need to do it. Hence lazy (in the good sense). 

To make a stored property lazy, simply add the `lazy` keyword in front of your stored property definition.

### 4. Computed Properties

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

**Exercise**

Complete [Part 1 of AC-iOS-Properties](https://github.com/C4Q/AC-iOS-Properties/tree/master)

### 5. Type Properties

Type properties are those that belong to the type itself, and not to any one instance. They are accessible without an instance of the class, and there will only ever be one copy of these properties, no matter how many instances of that type are created.

Type properties are useful for defining values that are universal to all instances of a particular type. Stored type properties can be variables or constants. Computed type properties are always declared as variable properties, in the same way as computed instance properties.

Unlike stored instance properties, you must always give stored type properties a default value. This is because the type itself does not have an initializer that can assign a value to a stored type property at initialization time.

#### Type Property Syntax

Mark ordinary properties with the keyword ```static```. 

```swift
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
```

For computed type properties for class types, you can use the `class` keyword instead to allow subclasses to override the superclass’s implementation. 

```swift
class var personalStatement: String {
    get {
        return "I am a human being!"
    }
}
```

#### Querying & Setting Type Properties
Type properties are queried and set with dot syntax, just like instance properties. However, type properties are queried and set on the type, not on an instance of that type. For example:

```swift
static var oath = "I do solemnly swear (or affirm) that I will faithfully execute the Office of President of the United States, and will to the best of my ability, preserve, protect and defend the Constitution of the United States."

President.oath
```

**Exercise**

Complete [Part 2 of AC-iOS-Properties](https://github.com/C4Q/AC-iOS-Properties/tree/master)

---

### 6. Access Control

Access control restricts access to parts of your code from code in other source files and modules. This feature enables you to hide the implementation details of your code, and to specify a preferred interface through which that code can be accessed and used.

#### Access Levels
Swift provides five different access levels for entities within your code. These access levels are relative to the source file in which an entity is defined.

| :-----: | :-----: |
|Access Level | Description |
| :-----: | :----- |
| Open | The highest (least restrictive) access level. Same as Public level except applies only to classes and class members.|
| Public | Enables entities to be used within any source file from their defining module, and also in a source file from another module that imports the defining module. You typically use open or public access when specifying the public interface to a framework.|
| Internal | Enables entities to be used within any source file from their defining module, but not in any source file outside of that module. You typically use internal access when defining an app’s or a framework’s internal structure. |
| Fileprivate | Restricts the use of an entity to its own defining source file. Use file-private access to hide the implementation details of a specific piece of functionality when those details are used within an entire file.|
| Private | Restricts the use of an entity to the enclosing declaration, and to extensions of that declaration that are in the same file. Use private access to hide the implementation details of a specific piece of functionality when those details are used only within a single declaration.|


You can define the access level for an entity by placing one of the `open`, `public`, `internal`, `fileprivate`, or `private` modifiers before the entity’s introducer:

```swift
public class SomePublicClass {}
internal class SomeInternalClass {}
fileprivate class SomeFilePrivateClass {}
private class SomePrivateClass {}
 
public var somePublicVariable = 0
internal let someInternalConstant = 0
fileprivate func someFilePrivateFunction() {}
private func somePrivateFunction() {}
```

Unless otherwise specified, the default access level is internal. This means that `SomeInternalClass` and `someInternalConstant` can be written without an explicit access-level modifier, and will still have an access level of internal:


```swift
class SomeInternalClass {}     // implicitly internal
let someInternalConstant = 0   // implicitly internal
```

---

### Review

* Compare and contrast the use of stored and computed properties.
* What are getters and setters?
* Why use access control?
