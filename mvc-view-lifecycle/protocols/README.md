
# Protocols

---
### Readings

1. [The Swift Programming Language (Swift 4): Protocols](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html)

---
### Protocols

A **protocol** defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to conform to that protocol.

---
### 1. Objectives

1. Create and use delegates
2. Begin to understand the protocols and the delegate design pattern in programming
3. Handle delegation in preparation for tomorrow

---


### 2. Why protocols?

When working with classes, we occasionally might want to try to inherit from two seperate classes.

```swift
class Seed {
  var plantName: String
  init(plantName: String) {
    self.plantName = plantName
  }
}

class Food {
  var calories: Int
  init(calories: Int) {
    self.calories = calories
  }
}

```
Now let's say that we want to define a class ```SunflowerSeed``` that is both a Seed and a Food.  How could you model this class?

<details>
<summary>Solution</summary>

It can't inherit from both classes, so you would have to pick one to from inherit from, and then reimplement the properties and methods of the other class yourself.

</details>


Situations like this do arise, so we need a better way of connecting objects to each other.  


### 3. What is a protocol?

A protocol is a collection of properties and methods.  Protocols can be *adopted* by classes, structs and enums.  In order for another class to adopt/conform to a protocol, it must provide its own implementation for **all** of the properties and methods defined inside of the protocol.  


When you define a protocol, you define **only** the properties and methods you want the implementing types to have, and not their values. If using properties, their read-write or read-only permissions have to be specified.

```swift
protocol SomeProtocol {
  var someString: String { get set }
  var someInt: Int { get }
  
  func someMethod()
  mutating func someMutatingMethod()
}
```

Whenever we want a type to conform to SomeProtocol, it must have its own implementation of someString, someInt, someMethod() and someMutatingMethod().


Because types can conform to more than one protocol, they can be decorated with default behaviors from multiple protocols. Unlike multiple inheritance of classes which some programming languages support, protocol extensions do not introduce any additional state.


### 4. Defining types that conform to Protocols (with Properties)

How can we make use of a protocol?  Let's define a protocol that says a struct or class that adopts it must have a fullName.

>From the Apple documentation
>

```swift 
protocol FullyNamed {
  var fullName: String { get }
}
```

**Exercise**: Redefine `Seed` and `Food` as protocols, then create a SunflowerSeed class that adopts both of them.  (Use the names "Plantable" and "Edible")

<details>
<summary>Solution</summary>

```swift
protocol Plantable {
  var plantType: String { get }
}

protocol Edible {
  var calories: Int { get }
}

class SunflowerSeed: Plantable, Edible {
  var plantType: String = "Sunflower"
  var calories: Int
  init(calories: Int) {
    self.calories = calories
  }
}
```
</details>

Now let's define a Person

```swift
struct Person {
  var age: Int
  var occupation: String
}
```

We want our person to *implement* (also *adopt* / *conform to*) the FullyNamed protocol.  This means that it must have its own implementation for all of the properties and methods that FullyNamed defines.

```swift
struct Person: FullyNamed {
  var age: Int
  var occupation: String
}
```

Why do we get a compile-time error here?
<details>
<summary>Answer</summary>
We don't have a fullName property defined.
</details>

**Exercise**: Fix the implementation above to remove the error

<details>
<summary>Answer</summary>

```swift 
struct Person: FullyNamed {
  var age: Int
  var occupation: String
  var fullName: String
}
```
</details>

**Exercise**: Make the Student class below conform to FullyNamed.

```swift 
class Student {
  var gpa: Double
  init(gpa: Double) {
    self.gpa = gpa
  }
}
```

<details>
<summary>Answer</summary>

```swift 
class Student: FullyNamed {
  var gpa: Double
  var fullName: String
  init(gpa: Double, fullName: String) {
    self.gpa = gpa
    self.fullName = fullName
  }
}
```
</details>

**Exercise** Make the TextColor enum below conform to FullyNamed

```swift
enum TextColor: String {
  case red = "Red"
  case green = "Green"
  case blue = "Blue"
}
```
<details>
<summary>Answer</summary>

```swift 
class TextColor: String, FullyNamed {
  case red = "Red"
  case green = "Green"
  case blue = "Blue"
  var name: String {
    return self.rawValue
  }
}
```
</details>


### 5. Defining types that conform to Protocols (with methods)

Just like we can define protocols with properties, we can define a protocol that requires classes/structs/enums that implement it to define certain methods.

```swift
struct Point {
  var x: Int
  var y: Int
}

protocol Movable {
  var currentPosition: Point { get }
  mutating func move(to newPoint: Point)
  mutating func moveStraightForTenSeconds() -> Point
}
```
For something to be Movable, it must have a currentPosition, an ability to move to a Point, and an ability to move straight for ten seconds.  


**Exercise:** Make a car class that implements Movable.

<details>
<summary>Solution</summary>

```swift
class Car: Movable {
  var currentPosition: Point = Point(x: 0, y: 0)
  func move(to newPoint: Point) {
    print("The car is moving!")
    self.currentPosition = newPoint
  }
  func moveStraightForTenSeconds() -> Point {
    currentPosition = Point(x: currentPosition.x + 10, y: currentPosition.y)
    return currentPosition
  }
  func useHorn() {
    print("Honk honk")
  }
}
```
</details>

**Exercise:** Make a Plane class that implements Movable.  You'll need to mark the methods in the original protocol as *mutating*.


<details>
<summary>Solution</summary>

```swift
struct Plane: Movable {
  var pilotName: String = "Otto"
  var currentPosition: Point = Point(x: 0, y: 0)
  mutating func move(to newPoint: Point) {
    print("The plane is moving!")
    currentPosition = newPoint
  }
  mutating func moveStraightForTenSeconds() -> Point {
    currentPosition = Point(x: currentPosition.x + 100, y: currentPosition.y)
    return currentPosition
  }
}
```
</details>


### 6. Classes that conform to protocols and inherit from other classes


```swift
class Person {
  var age: Int
  var occupation: String
  init(age: Int, occupation: String) {
    self.age = age
    self.occupation = occupation
  }
}

protocol FullyNamed {
  var fullName: String { get }
}
```

A class can inherit from a class *and* conform to a protocol.  

```swift
class Student: Person, FullyNamed {
  var fullName: String
  var gpa: Double
  init(age: Int, occupation: String, fullName: String, gpa: Double){
    self.gpa = gpa
    self.fullName = fullName
    super.init(age: age, occupation: occupation)
  }
}
```

Put the name of any inherited classes first, then any protocols that it is conforming to.

A class can inherit from only one class, but it can conform to any number of protocols.

```swift
class Student: Person, FullyNamed, Movable {
  var fullName: String
  var gpa: Double
  var currentPosition = Point(x: 0, y: 0)
  func move(to newPoint: Point) {
    print("\(fullName) is moving!")
    currentPosition = newPoint
  }
  func moveStraightForTenSeconds() {
    return Point(x: currentPosition.x + 10, y: currentPosition.y)
  }
  init(age: Int, occupation: String, fullName: String, gpa: Double){
    self.gpa = gpa
    self.fullName = fullName
    super.init(age: age, occupation: occupation)
  }
}
```

### 8. Some common Protocols in Swift 

Here are some common protocols in iOS:

- CaseIterable
- Equatable
- Comparable
- Hashable
- Collection
- Sequence
- CustomStringConvertible

We have seen CaseIterable when we introduced Enumerations. When we conformed to CaseIterable we were able to get all the cases on our enum, with that .allCases property we were able to use a for-in loop to iterate over the enum. We'll talk about the other Protocols in more detail later in the course, below we are making use `CustomStringConvertible` `Equatable` and `Comparable`.  Conforming to this protocol means that you can control what the print() function does.

```swift
class Person: CustomStringConvertible, Equatable, Comparable {
  static func < (lhs: Person, rhs: Person) -> Bool {
    return lhs.age < rhs.age
  }
  
  static func == (lhs: Person, rhs: Person) -> Bool {
    return lhs.age == rhs.age && lhs.occupation == rhs.occupation
  }
  
  var age: Int
  var occupation: String
  
  var description: String {
    return "Person\'s age is \(age) and their occupation is \(occupation)"
  }
  
  init(age: Int, occupation: String) {
    self.age = age
    self.occupation = occupation
  }
}
let john = Person(age: 39, occupation: "Apple Developer")
let kim = Person(age: 35, occupation: "Data Scientist")
print(john)
// Person's age is 39 and their occupation is Apple Developer

print(kim)
// Person's age is 35 and their occupation is Data Scientist


if john == kim { // Binary operator '==' cannot be applied to two 'Person' operands
  print("They're the same person")
} else {
  print("different people")
}

let sortedPeople = [john, kim].sorted { $0 < $1 } // Binary operator '<' cannot be applied to two 'Person' operands
print(sortedPeople)
// [Person's age is 35 and their occupation is Data Scientist, Person's age is 39 and their occupation is Apple Developer]
```

### 9. Delegation 

Delegation is a design pattern that enables a class or structure to hand off (or delegate) some of its responsibilities to an instance of another type. This design pattern is implemented by defining a protocol that encapsulates the delegated responsibilities, such that a conforming type (known as a delegate) is guaranteed to provide the functionality that has been delegated. Delegation can be used to respond to a particular action, or to retrieve data from an external source without needing to know the underlying type of that source.

The GameDelegate below defines two required methods (startGame() and endGame() )  a conforming type needs to implement. The GameDelegate also restricts the conforming type to be a class by using AnyObject. This is required to break the memory cycle on the delegate as we will describe below.

In the BlackJackGame class `weak` is used to break the memory retain cycle on the delegate. More about memory management in a later unit. In the gameStatus() method the delegate is set on the endGame method (we will see that data objects can also be passed here e.g a final score), at this point any conforming class will get the data or updates passed to it from gameStatus(). 

The BlackJackViewController class conforms to BlackJackDelegate and is required to implement startGame() and endGame(). An instance of the BlackJackGame is created. When the BlackJackGame instance invokes the gameStatus() method the blackJackViewController instance recieves updates and the print statement "Looks like we have a winner" gets printed.

```swift 
protocol GameDelegate: AnyObject {
  func startGame()
  func endGame()
}

class BlackJackGame {
  weak var delegate: GameDelegate?
  
  func gameStatus() {
    delegate?.endGame()
  }
}

class BlackJackViewContorller: UIViewController, GameDelegate {
  func startGame() {
    print("BlackJack Started")
  }
  
  func endGame() {
    print("Looks like we have a winner!")
  }
}

var blackJackGame = BlackJackGame()
var viewcontroller = BlackJackViewContorller()

blackJackGame.delegate = viewcontroller
blackJackGame.gameStatus() // as this method is invoked the print statement in endGame is printed since this method is set on the delegate in the BlackJackGame

// Looks like we have a winner!
```

### 10. Optional protocol methods


In Swift, when you want to conform to a protocol, you must implement **all** its properties and methods.  However, in Objective-C, you could mark certain methods as optional.  You will see this in iOS programming, you can choose whether or not to implement certain methods from a protocol.

```swift
@objc protocol FullyNamed {
  var fullName: String { get }
  @objc optional func printName()
}
```
