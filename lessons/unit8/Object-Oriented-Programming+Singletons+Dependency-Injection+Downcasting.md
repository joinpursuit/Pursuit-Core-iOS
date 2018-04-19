## Object Oriented Programming, Encapsulation, Singletons, Dependency Injection, Downcasting, Inheritance

## Review
* Object Oriented Programming 
* Singletions
* Dependency Injection 
* Downcasting 

## Key Interview Questions
* What is Object Oriented Programming?
* What is encapsulation?
* What is inheritance? Give an example of when it is used in building an iOS application.
* What is a Singleton? What are the advantages and disadvantages of using a Singleton?
* What is Dependency Injection and why can it be useful?
* What is downcasting? Give an example of when you would use downcasting in an iOS application.

## Object Oriented Programming 
Object-oriented programming (OOP) is a programming paradigm that represents the concept of “objects” that have data fields (attributes that describe the object) and associated procedures known as methods. Objects, which are usually instances of classes, are used to interact with one another to design applications and computer programs.

>There are 3 key aspects of object oriented programming:

>**Encapsulation** means that objects keep their state information private. Rather than directly manipulating an object’s data, other objects send requests to the object, in the form of messages, some of which the object may respond to by altering its internal state.

>**Polymorphism** means that objects of different classes can be used interchangeably. This is especially important, as it allows you to hook up classes at a later date in ways you didn’t necessarily foresee when those classes were first designed.

>**Inheritance** means that objects of one class can derive part of their behavior from another (base or parent) class. Some object-oriented languages (C++, for example, but not Swift) allow multiple inheritance, where objects of one class can derive part or all of their behavior from multiple independent base classes.

Shows inheritance and polymorphism
```swift 
class Vehicle {
    var maxSpeed: Int = 0
    var numberOfWheels: Int = 0
    var color: UIColor = .red
}

class Car: Vehicle {}

class Rocket: Vehicle {}

func setMaxSpeed(vehicle: Vehicle) {
    vehicle.maxSpeed = 200
    print("max speed is \(vehicle.maxSpeed)")
    print("color is \(vehicle.color)")
}

let aVehicle = Rocket()
setMaxSpeed(vehicle: aVehicle)
```

## Singleton 
A Singleton is a design pattern used for ensuring that there is a single, globally shared instance of a custom class. A Singleton is essentially just a global variable. It can be useful if there is a global state that you might need to access or manipulate that everything in your app could want to access.  

The main advantage of using a Singleton is that it has global state. So in instances where you want to have access to a class anywhere in your program it becomes quite useful. 

Ironically enough on the other hand a Singleton's main advantage can also lead to lots of bugs in your code due to state changes because of its global nature - any class can change its state. Code in a Singleton may start out being small and manageable, but most times than not it will become bloated as more functionality is added, this leads to a testing nightmare. With that said Apple uses Singletons throughtout iOS e.g FileManager, UserDefaults, UIApplication so use sparingly in your own codebase. 

```swift 
class DataManager {
    private init() {}
    static let shared = DataManager()
    
    var items = 20

    func getItems() -> Int {
        return items
    }
    
    func setItems(items: Int) {
        self.items = items
    }
}

DataManager.shared.getItems()

// anyone can set items since its global
DataManager.shared.setItems(items: 50)

DataManager.shared.getItems()
```

## Dependency Injection 
>Dependency injection means giving an object its instance variables. Really. That's it. - [James Shore](http://www.jamesshore.com/Blog/Dependency-Injection-Demystified.html)

```swift 
struct Fellow {
    let name: String
    let email: String
}

class ViewController: UIViewController {
    private var fellow: Fellow!
    init(fellow: Fellow) {
        super.init(nibName: nil, bundle: nil)
        self.fellow = fellow
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello \(fellow.name)")
    }
}

let fellow = Fellow.init(name: "John Appleseed", email: "appleseed@c4q.nyc")
let viewController = ViewController(fellow: fellow)
```

## Downcasting 
A constant or variable of a certain class type may actually refer to an instance of a subclass behind the scenes. Where you believe this is the case, you can try to downcast to the subclass type with a type cast operator (as? or as!)

In this example, each item in the array might be a Movie, or it might be a Song. You don’t know in advance which actual class to use for each item, and so it is appropriate to use the conditional form of the type cast operator (as?) to check the downcast each time through the loop:

```swift 
for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    }
}
 
// Movie: Casablanca, dir. Michael Curtiz
// Song: Blue Suede Shoes, by Elvis Presley
// Movie: Citizen Kane, dir. Orson Welles
// Song: The One And Only, by Chesney Hawkes
// Song: Never Gonna Give You Up, by Rick Astley
```


| Resource | Summary |
|:------|:-------|
| [Unit 1 - Structs and Classes](https://github.com/C4Q/AC-iOS/blob/16ba4187915e51556e4822df07b74428bceb4d6f/lessons/unit1/structs-and-classes/README.md) | Object Oriented Programming, Encapsulation, Inheritance |
| [Unit 3 - Getting Data From Online](https://github.com/C4Q/AC-iOS/tree/master/lessons/unit3/GettingDataFromOnline) | Singletons, Pros and Cons |
| [Unit 3 - Parsing JSON](https://github.com/C4Q/AC-iOS/tree/master/lessons/unit3/ParsingJSON) | Downcasting, Codable, Parsing JSON, JSONSerialization, JSONDecoder |
| [Unit 4 - Programmatic View Management](https://github.com/C4Q/AC-iOS/tree/master/lessons/unit4/Programmatic-View-Management) | Dependency Injection, Frame vs Bounds |
| [Unit 5 - Test Driven Development](https://github.com/C4Q/AC-iOS/blob/6ca054d0bc775e4e7bc8a534dac74befe779bf03/lessons/unit5/TestDrivenDevelopment/README.md) | Test Driven Development, Dependency Injection |
| [Cocoacasts](https://cocoacasts.com/are-singletons-bad/) | Are Singletons Bad? |
| [Cocoacasts](https://cocoacasts.com/nuts-and-bolts-of-dependency-injection-in-swift/) | Nuts and Bolts of Dependency Injection in Swift |
| [The Swift Programming Language](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/TypeCasting.html) | Type Casting, Downcasting, Checking Type |
| [We ❤️ Swift](https://www.weheartswift.com/object-oriented-programming-swift/) | Object Oriented Programming in Swift |


## DSA Exercises 

**Exercise 1**:  
Reverse the words in a string  
<br>
Sample input and output  
- Coalition for Queens should be noitilaoC rof sneeuQ
- The quick brown fox should be ehT kciuq nworb xof

**Exercise 2**:  
Write a function that counts from 1 to 100,  
prints "Fizz" if the count is evenly divisible by 3,  
"Buzz" if it's evenly divisible by 5,  
"Fizz Buzz" if it's even divible by 3 and 5,  
or the counter number for all other cases  
<br>
Sample input and output  
- 1 should print "1"  
- 2 should print 2  
- 3 should print "Fizz"  
- 4 should print "4"  
- 5 should print "Buzz"  
- 15 should print "Fizz Buzz"  

**Exercise 3**:  
Write a function that returns a URL to the user's documents directory

**Exercise 4**:  
Create a function that accepts an array of unsorted numbers from 1 t0 100 where zero or more
numbers might be missing, and returns an array of the missing numbers  
<br>
Sample input and output   
var testArray = Array(1...100)  
testArray.remove(at: 45)  
testArray.remove(at: 0)  
will return [1, 46]  

**Exercise 5**:  
Write a function that accepts a variadic array of integers and return
the sum of all numbers that appear an even number of times  
<br>
Sample input and output  
sumEvenRepeats(numbers: 1,2,2,3,3,4) should return 5  
sumEvenRepeats(numbers: 1,2,2,3,3,4,10,10) return 15
 
