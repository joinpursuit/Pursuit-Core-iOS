
# AC-iOS Protocols (feat. a bit of Delegation)

---
### Readings

1. [The Swift Programming Language (Swift 4): Protocols](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html)

---
### Vocabulary

1. **Protocol**: ... A protocol is a list of prerequisites to inherit a title. A protocol is: you need this, this, and this. To be called this. ```You need to drink, party, and procrastinate to be called a stereotypical college student.``` [Medium](https://medium.com/ios-os-x-development/introduction-to-protocols-in-swift-3-73f9a9be6b15)
2. **Delegate**: ... pattern in which one object in a program acts on behalf of, or in coordination with, another object. The delegating object keeps a reference to the other object—the delegate—and at the appropriate time sends a message to it. The message informs the delegate of an event that the delegating object is about to handle or has just handled. [Apple](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Delegation.html)

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
protocol Edible {
	var calories: Int {get}
}
protocol Plantable {
	var plantType: String {get}
}
class SunflowerSeed: Edible, Plantable {
	var calories: Int
	var plantType: String = "Sunflower"
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
	var currentPosition: Point {get}
	func move(to: Point)
	func moveStraightForTenSeconds() -> Point
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
        self.currentPosition = Point(x: self.currentPosition.x + 10, y: self.currentPosition.y)
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
	 var pilotName: Sting = "Otto"
    var currentPosition: Point = Point(x: 0, y: 0)
    func move(to newPoint: Point) {
    	 print("The plane is moving!")
        self.currentPosition = newPoint
    }
    func moveStraightForTenSeconds() -> Point {
        self.currentPosition = Point(x: self.currentPosition.x + 100, y: self.currentPosition.y)
        return currentPosition
    }
}
```
</details>



### 6. Using Protocols as types

We can also use protocols as types.  This means that we don't know what the "real" type is, but we are free to refer to all the methods and properties that the protocol defines.

```swift
var movableThings: [Movable]()
let myCar = Car()
let myPlane = Plane()
movableThings = [myCar, myPlane]
```

Even though my array has a `Car` and a `Plane` in it, we can create this array of `[Movable]`.  As we iterate through the array, we can't refer to any specific `Car` or `Plane` properties, but we can refer to their currentPosition properties and call move(to:) and moveForTenSeconds(). 

```swift
for movableThing in movableThings {
	//These all work
	print(movableThing.currentPosition)
	movableThing.move(to: Point(x: 10, y:10))
	movableThing.moveForTenSeconds()
	
	//THESE WILL NOT WORK
	//movableThing.pilotName
	//movableThing.honk()
}
```

### 7. Classes that conform to protocols and inherit from other classes


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
		print("\(self.fullName) is moving!")
		self.currentPosition = newPoint
	}
	func moveStraightForTenSeconds() {
		return Point(x: self.currentPosition.x + 10, y: self.currentPosition.y) 
	}
	init(age: Int, occupation: String, fullName: String, gpa: Double){
		self.gpa = gpa
		self.fullName = fullName
		super.init(age: age, occupation: occupation)
	}
}

```

### 8. Protocol inheritence

Protocols also support a version of inheritence.

```swift
protocol Titled  {
	var title: String {get}
}
```

```swift
class Teacher: Person, Titled {
	var fullName: String
	var title: String
	init(fullName: String, title: String, age: Int) {
		self.fullName = fullName
		self.title = title
		super.init(age: age, occupation: "Teacher")
	}
}
```


### 9. Protocol-oriented programming in Swift 

You may have heard the phrase "Object Oriented Programming".  Swift is a Protocol-oriented language.  That means that the fundemental building blocks of Swift are built on top of protocols.  Here are some main ones that you see:

- Equatable
- Comparable
- Hashable
- Collection
- Sequence
- CustomStringConvertible

We'll talk about these in more detail later, but a fun one to use is `CustomStringConvertible`.  Conforming to this protocol means that you can control what the print() function does.

```
class Person: CustomStringConvertible {
    var age: Int
    var occupation: String
    var description: String {
    	return "Person: age: \(age), occupation: \(occupation)"
    }
    init(age: Int, occupation: String) {
        self.age = age
        self.occupation = occupation
    }
}

let person = Person(age: 40, occupation: "Pilot")
print(person)
```

### 10. Optional protocol methods


In Swift, when you want to conform to a protocol, you must implement **all** its properties and methods.  However, in Objective-C, you could mark certain methods as optional.  You will see this in iOS programming, you can choose whether or not to implement certain methods from a protocol.

```swift
@objc protocol FullyNamed {
	var fullName: String {get}
    @objc optional func printName()
}
```


---
### 11. Delegation

One of the most common uses of protocols is inside a Swift design pattern called "Delegation"

Imagine a job posting for a personal assistant by some employer:

> **Help Wanted:**
>
> **Seeking**: Personal Assistant
>
> **Needed Skills**: Organizing Calendar, Taking Calls, Running Errands

The employer looking for an assistant is likely busy with other things, so much so that they don't have time to *organize their calendar*, or *take all their calls*, or *run errands*. But, they're willing to delegate out some of their responsibilities to their assistant. The employer doesn't really have preference for how their assistant does these tasks - they're only concerned that the tasks get done. And once something gets done, they only want to be informed by their assistant.

Think of a `protocol` as a job posting looking for certain skills:

```swift

// "job posting" PersonalAssistant
protocol PersonalAssistant {
  func organizeCalendar()
  func takeCalls() -> Bool
  func runErrands()
}

```

The employer doesn't necessarily care who they're hiring, just that they can do the functions required. So, a human that could do those tasks would be as valuable to them as a robot, or cat, or dolphin.

A class/struct/enum that is qualified to be a `PersonalAssistant` does their functions on behalf of their "employer." Their "employer" has delegated out some of their duties, and really is only concerned that they happened. When an object is "qualified" to be a `PersonalAssistant`, it is said that they "**conform**" to the `PersonalAssistant protocol`.

#### The `Employer`

To continue the analogy, let's create a class called `Employer`. This `Employer` will have a property called `delegate` of type `PersonalAssistant?`. Why optional? Well, the `Employer` doesn't necessarily have a `PersonalAssistant` right off the bat -- they may need to "hire" one. For that, we'll add a function called `hirePersonalAssistant`. Lastly, the `Employer` needs to be able to declare that they are busy at a meeting and can't take any calls.

```swift
  class Employer {
    // 1. this is optional because we may have not yet "hired" an assistant
    var delegate: PersonalAssistant?

    // 2. We can hire a new assistant
    func hirePersonalAssistant(_ assistant: PersonalAssistant) {
      self.delegate = assistant
    }

    // 3. Employer is going to a meeting, so their calls need to be handled somehow
    func busyAtAMeeting() {
        if let delegate = self.delegate {
           if delegate.takeCalls() {
                print("Delegate is taking the call")
            }
        } else {
            print("Calls going to voicemail")
        }
    }
  }
```

#### The `Employee: PersonalAssistant`

On the other side of things, we have an `Employee` class. The `Employee` is interested in applying to be a `PersonalAssistant`, which means that they can guarantee that they can fulfill the required tasks of `organizeCalendar()`, `takeCalls()`, and `runErrands`.

```swift
  // This Employee conforms to the PersonalAssistant protocol
  class Employee: PersonalAssistant {

    // 1. This employee has an additional ability outside of the requirements of the job description (being able to greeting people)
    func greet() {
        print("Hi there, I'm your Personal Assistant")
    }

    // 2. But because Employee conforms to the PersonalAssistant protocol/job description,
    //    its required skills are to organizeCalendar, takeCalls, and runErrands
    func organizeCalendar() {
      print("Organizing your calendar")
    }

    func takeCalls() -> Bool {
      print("Answering calls")
      return true
    }
    func runErrands() {
        print("Off running some errands")
    }
  }
```

#### First Day on the Job

To see delegation in action, we could imagine `Employee`'s first day on the job looking like this:

```swift

// 8am, Employer gets into work. An Employee is coming in at 9am for an interview
let boss = Employer()

// 8:30am, boss has a meeting to go to
boss.busyAtAMeeting() // prints "Calls going to voicemail"

// 9am. Employee arrives for the interview to be a PersonalAssistant
let assistant = Employee()
assistant.greet() // prints "Hi there, I'm your Personal Assistant" ... boss thinks this is a little too soon, they haven't gotten the job yet... 🤦‍♂️

// 10am. boss is so impressed by the new assistant! hires them right on the spot❗❗❗ 💰
boss.hirePersonalAssistant(assistant)

// 11am. boss heads into another meeting. but now has an assistant!
boss.busyAtAMeeting()   // assistant prints "Answering calls"
                        // boss prints "Delegate is taking the call"

// 12pm. boss and assistant take lunch and bond 🤝
```



-
### 12 More Examples with Protocols

In the below, check out some nuances with using protocols.

```swift
// 1: As always, note the protocols below with the function and property stubs
protocol Animal {
    var name: String { get }
    func pet()
}

protocol Cat {
    var badCat: Bool { get }
    func purr()
}

protocol Dog {
    var goodDoggie: Bool { get }
}

// 2: Welp, here are the animals that we want to create. Notice how this class conforms to both of the protocols we created.
class Kitteh: Animal, Cat {
    var name: String = "Meow Mix" // from Animal
    var badCat: Bool = true // from Cat

    func pet() { // Animal again
        self.purr()
    }

    func purr() { // Cat again
        badCat = !badCat
        print("Purrrrr~~ ")
    }
}

// 3. Check it out, a struct!
struct Doggo: Animal, Dog {
    var name: String = "upDog" // from Animal
    var goodDoggie: Bool = true // from Dog

    func pet() { // from Animal
        print("Ew. Slobber.")
    }
}

var kitty = Kitteh()
var doggy = Doggo()

// 4: You can store them in arrays of their types! Dogs and cats living together, mass hysteria
let petShop: [Animal] = [kitty, doggy] // class, struct

petShop.map { $0.pet() }

protocol ExampleProtocol {
    // 5: This is a get-only property! But-- read on for drama
    var simpleDescription: String { get }
    // 6: Keep note of the mutating func.
    mutating func adjust()
}

struct SimpleStruct: ExampleProtocol {
    var simpleDescription: String = "This is a simple String!"

    mutating func adjust() {
        simpleDescription += "  Now 100% adjusted."
        print(simpleDescription)
    }
}

class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "This is a simple String!"

    func adjust() { // 7. Does not have to be mutating since this is a Class
        simpleDescription += " Now 100% adjusted."
        print(simpleDescription)
    }
}

var simpleClass = SimpleClass()
var simpleStruct = SimpleStruct()
simpleClass.adjust()
simpleStruct.adjust()

// 8. And here we change the description...
simpleClass.simpleDescription = "We changed this"
simpleStruct.simpleDescription = "We changed this too"

// If the protocol only requires a property to be gettable, the requirement can be satisfied by any kind of property, and it’s valid for the property to be also settable if this is useful for your own code. In the above, the Class and Struct strings are by default read-write / gettable and settable .

// 9. Protocols can enforce therse permissions if you cast it as a a protocol
var protoClass = SimpleClass() as ExampleProtocol
var protoStruct: ExampleProtocol = SimpleStruct()

//protoClass.simpleDescription = "Hello" // NOPE
//protoStruct.simpleDescription = "Hello" // NOT HERE NEITHER

// 10. This protocol has a read-write String
protocol EditableProperties {
    var editThis: String { get set }
}

class EditClass: EditableProperties {
    var editThis: String = "Hello"
}

class EditStruct: EditableProperties {
    var editThis: String = "Hello"
}

// 11. YUP. STRINGS ARE CHANGED
var editClass: EditableProperties = EditClass()
editClass.editThis = "Hiya"

var editStruct: EditableProperties = EditStruct()
editStruct.editThis = "Okay"
```
