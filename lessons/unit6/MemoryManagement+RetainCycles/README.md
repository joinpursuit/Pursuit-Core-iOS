# Memory Management / Retail Cycles

# Objectives

1. Explain what ARC is and why its used
2. Explain strong, weak and unowned reference types
3. Understand what a retain cycle is and explain how to avoid them
4. Write code that prevents retain cycles from occuring


# 1. What is ARC?

ARC stands for Automatic Reference Counting.  It's the process by which iOS cleans up objects that no longer need to be held in memory.  Once an object no longer has anything that references it, it can be taken out of memory.

```swift
class Person {
    var name: String
    init(name: String) {
        self.name = name  
    }
}

var testPerson: Person? = nil
testPerson = Person(name: "Abe")
```

This creates the following picture:

```
(testPerson) --->  New Person Object: "Abe"
```

If we set testPerson to nil again, there is no reason to hold the Person object in memory anymore.  No one is referring to it, so it isn't posslbe for anyone to care about its properties.  Swift (or Objective-C) can then safely deinitialize the Person object.  We can see this happening directly by adding a special method called *deinit*.  Just like *init* is called when we create an object, *deinit* is called when the object is deallocated from memory.


```swift
class Person {
    var name: String
    init(name: String) {
        self.name = name
        print("Initialized person \(self.name)")
    }
    deinit {
        print("Deinitializing person \(self.name)")
    }
}


var myPerson: Person?
myPerson = Person(name: "Abe")
myPerson = nil
```

Abe will also be deinitialized if we reassign myPerson to someone else:

```

```