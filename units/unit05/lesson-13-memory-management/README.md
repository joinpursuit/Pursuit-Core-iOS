# Memory Management 

## ARC (Automatic Reference Counting)

Swift uses Automatic Reference Counting (ARC) to track and manage your app’s memory usage. In most cases, this means that memory management “just works” in Swift, and you do not need to think about memory management yourself. ARC automatically frees up the memory used by class instances when those instances are no longer needed.

However, in a few cases ARC requires more information about the relationships between parts of your code in order to manage memory for you. 

## Readings
[Swift Docs - ARC (Automatic Reference Counting)](https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html)  
[Stackoverflow - when to use weak or unowned](https://stackoverflow.com/questions/24320347/shall-we-always-use-unowned-self-inside-closure-in-swift)

## Strong 

whenever you assign a class instance to a property, constant, or variable, that property, constant, or variable makes a strong reference to the instance. The reference is called a “strong” reference because it keeps a firm hold on that instance, and does not allow it to be deallocated for as long as that strong reference remains.

## Weak 

You resolve strong reference cycles by defining some of the relationships between classes as weak or unowned references instead of as strong references. Weak and unowned references enable one instance in a reference cycle to refer to the other instance without keeping a strong hold on it. The instances can then refer to each other without creating a strong reference cycle. 

A weak reference is a reference that does not keep a strong hold on the instance it refers to, and so does not stop ARC from disposing of the referenced instance. This behavior prevents the reference from becoming part of a strong reference cycle. You indicate a weak reference by placing the weak keyword before a property or variable declaration.


## Unowned

Like a weak reference, an unowned reference does not keep a strong hold on the instance it refers to. Unlike a weak reference, however, an unowned reference is used when the other instance has the same lifetime or a longer lifetime. You indicate an unowned reference by placing the unowned keyword before a property or variable declaration.


# ARC - Strong Reference Cycle Example

```swift 
import UIKit

class Tenant {
  var name: String
  var apartment: Apartment?
  init(name: String) {
    self.name = name
    print("\(name) is being initialized")
  }
  deinit {
    print("\(name) is being deinitialized")
  }
}

class Apartment {
  var unit: String
  var tenant: Tenant?
  init(unit: String) {
    self.unit = unit
    print("\(unit) is being initialized")
  }
  deinit {
    print("\(unit) is being deinitialized")
  }
}

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    var apartment: Apartment? = Apartment(unit: "Apt 6B")
    var alex: Tenant? = Tenant(name: "Alex")
    
    apartment?.tenant = alex
    alex?.apartment = apartment
    
    alex = nil
    
    apartment = nil
  }
}
```

## Using the Debug Memory Graph

To investigate memory issues in your app you can use the **Memory Graph Debugger** It can be found next to the **Visual Debbugger** button in Xcode. 

<p align="center">
  <img src="https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/units/unit05/lesson-13-memory-management/Images/memory-graph-debugger.png" width="273" height="129" />
</p>


Visual Debugger shows a strong reference cycle between Apartment and Tenant classes. 
<p align="center">
  <img src="https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/units/unit05/lesson-13-memory-management/Images/strong-reference-cycle.png" width="429" height="427" />
</p>

**Let's resolve this memory cycle. **

<p align="center">
  <img src="https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/units/unit05/lesson-13-memory-management/Images/weak-reference.jpg" width="700" height="525" />
</p>

We will mark one of the classes **weak** to break the reference cycle
```swift 
weak var apartment: Apartment?
```


## Resolving Strong Reference Cycles for Closures 

> Swift requires you to write self.someProperty or self.someMethod() (rather than just someProperty or someMethod()) whenever > you refer to a member of self within a closure. This helps you remember that it’s possible to capture self by accident.

Use a capture list to break the strong reference cycle with closures. 

1. If you know the object e.g self will be on the heap after the closure is done you can use 
```swift 
[unowned self]
```
NB: If you use unowned and the object is no longer on the heap the app will crash, by default use weak unless you are absolutely sure self will be around. 

2. If there is a possibility that the object calling the closure will leave the heap making it nil then use 
```swift 
[weak self]
```

## Difference between unowned and weak

The difference between unowned and weak is that weak is declared as an Optional while unowned is not. By declaring it weak you get to handle the case that it might be nil inside the closure at some point. If you try to access an unowned variable that happens to be nil, it will crash the whole program. So only use unowned when you are positive that variable will always be around while the closure is around
