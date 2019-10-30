## Key-Value Observing

## Objectives 
* What is Key-Value Observing 
* Implementing Key-Value Observing  

## Key-Value Observing 
Key-value observing is a mechanism that allows objects to be notified of changes to specified properties of other objects. You can use key-value observing with a Swift class, as long as the class inherits from the NSObject class. 

You can use these two steps to implement key-value observing in Swift.
1. Add the dynamic modifier and @objc attribute to any property you want to observe. For more information on dynamic, see [Requiring Dynamic Dispatch](https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/InteractingWithObjective-CAPIs.html#//apple_ref/doc/uid/TP40014216-CH4-ID57).  
> 
```swift 
class MyObjectToObserve: NSObject {
    @objc dynamic var myDate = NSDate()
    func updateDate() {
        myDate = NSDate()
    }
}
```
2. Create an observer for the key path and call the ```observe(_:options:changeHandler)``` method. For more information on key paths, see [Keys and Key Paths](https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/InteractingWithObjective-CAPIs.html#//apple_ref/doc/uid/TP40014216-CH4-ID205).  
>
```swift 
class MyObserver: NSObject {
    @objc var objectToObserve: MyObjectToObserve
    var observation: NSKeyValueObservation?
    
    init(object: MyObjectToObserve) {
        objectToObserve = object
        super.init()
        
        observation = observe(\.objectToObserve.myDate) { object, change in
            print("Observed a change to \(object.objectToObserve).myDate, updated to: \(object.objectToObserve.myDate)")
        }
    }
}
 
let observed = MyObjectToObserve()
let observer = MyObserver(object: observed)
 
observed.updateDate()
```

## Types of ways to listen to Events in iOS 
* Key-Value Observing
* Callbacks
* NSNotificationCenter
* Delegation 
* Property Observers 
  
**KVO’s primary benefit is that you don’t have to implement your own scheme to send notifications every time a property changes.** 

Its well-defined infrastructure has framework-level support that makes it easy to adopt—typically you do not have to add any code to your project. In addition, the infrastructure is already full-featured, which makes it easy to support multiple observers for a single property, as well as dependent values.

Unlike notifications that use NSNotificationCenter, there is no central object that provides change notification for all observers. Instead, notifications are sent directly to the observing objects when changes are made. NSObject provides this base implementation of key-value observing, and you should rarely need to override these methods.

|Resources|Summary|
|:-----|:-----|
|[Intro to Key-Value Observing](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/KeyValueObserving/KeyValueObserving.html)|Introduction to Key-Value Observing Programming Guide|
|[Using Swift with Cocoa and Objective-C](https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/AdoptingCocoaDesignPatterns.html)|Using Swift with Cocoa and Objective-C|
|[NSKeyValueObserving](https://developer.apple.com/documentation/foundation/notifications/nskeyvalueobserving)|An informal protocol that objects adopt to be notified of changes to the specified properties of other objects|
|[Hacking with Swift](https://www.hackingwithswift.com/example-code/language/what-is-key-value-observing)|What is key-value observing?|
