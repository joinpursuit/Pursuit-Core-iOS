import UIKit

var str = "Hello, playground"

//i have a class
//classes can inherit
//ex: ancestor -> predecessor -> lil ol me
//class Food {
//    var calories: Int
//
//    init(calories: Int){
//        self.calories = calories
//    }
//}
//
////some seeds aren't food. fish are friends not food. so! seed cannot inherit from food, and so we can't create a nice smooth inheritance chain Food -> Seed -> sub class of seed (ex: SunflowerSeed)
//
//class Seed {
//    var plantName: String
//
//    init(plantName: String) {
//        self.plantName = plantName
//    }
//}
////i can do two things with a sunflower seed. olimpia also makes butter.
//
//class SunflowerSeed: Seed {
//    //i could declare this property, but it has no context... i don't know that calories relate to being a food-like thing
//    var calories: Int
//
//    init(calories: Int, plantName: String) {
//        self.calories = calories
//        super.init(plantName: plantName)
//    }
//}

//let's try it again with protocols!

// protocol (keyword) NameOfProtocol (name) {
// var someInt: Int
// var someString: String
// func someFunction() {}
// }

/*
// these ADOPT the protocol
// class SomeClass: NameOfProtocol {
 var someInt: Int = 3
 var someString: String
 
 init(someString: String) {
    self.someString = someString
 }
 
 func someFunction() {}
 }
// struct SomeStruct: NameOfProtocol1, NameOfProtocol2 {}
// enum SomeEnum: NameOfProtocol1, NameOfProtocol2 {}
*/

//name tells us what it's job is (loosely)
//protocol FullyNamed {
    //properties are computed because the protocol itself doesnt' store values
    //in protocol, you only have to say what type of computed values the property will have (read-only or read-write)
//    var fullName: String { get }
//}
//
//struct Person: FullyNamed {
//    //to conform to the protocol, what do i need?
//    //i will need to implement all properties and methods of that protocol!
//    var fullName: String
//}
//
//struct Dog: FullyNamed {
//    var barkSound: String
//    var fullName: String
//
//}
//
//var alyson = Person(fullName: "Alyson Abril")


//protocol Foodlike {
//    var poisonous: Bool { get }
//    var consistency: String { get set }
//    var calories: Int { get set }
//    func munch() -> Int
//}
//
//protocol Seedy {
//    var canGrowPlant: Bool { get set }
//    var shape: String { get }
//}
//
//struct SunflowerSeed: Foodlike, Seedy {
//    // poisonous is a constant, so you can only get it by its implementation here.
//    let poisonous: Bool = false
//    var consistency: String
//    var calories: Int
//
//    var canGrowPlant: Bool
//    var shape: String //you CAN get it, so that's good. you can also set it
//
//    func munch() -> Int {
//        return calories
//    }
//}
//
//var sfls = SunflowerSeed(poisonous: true, consistency: "crunchy awesome", calories: 6, canGrowPlant: true, shape: "wavy teardrop")
//
//sfls.consistency = "fluffy"
//sfls.shape = "nonwavy teardrop"
////print(sfls)
//let oneMouthful = sfls.munch()
//print("I just chewed \(oneMouthful) calories of that \(sfls.consistency) sunflower seed ")

//ambiguous bc it might also mean scary/unsavory
// struct SunflowerSeed

// The core purpose of the delegate pattern is to allow an object to communicate back to its owner in a decoupled way. By not requiring an object to know the concrete type of its owner, we can write code that is much easier to reuse and maintain.

//Delegation is usually a good choice when a type needs to be usable in many different contexts

//get only property ex: array.count


protocol FullyNamed {
//change this up by getting rid of fullName - give it a couple properties that, when implemented, make up each part of the name (a couple different strings) and an instance method that will return the full name as a string
    var firstName: String { get set }
    var middleName: String? { get set }
    var lastName: String { get set }
    
    func fullName() -> String
    
}

//create a struct called Person that conforms to the protocol FullyNamed.

struct Person : FullyNamed, Comparable, CustomStringConvertible {
    var description: String {
        get  {
            if let bindedMiddleName = middleName {
                return "\(firstName) \(bindedMiddleName) \(lastName)"
            } else {
                return "\(firstName) \(lastName)"
            }
        }
    }
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.netWorth > rhs.netWorth
    }
    
    var netWorth: Int
    var firstName: String
    var middleName: String?
    var lastName: String
    
    init(firstName: String, lastName: String){
        //leaves out the middle name
        self.firstName = firstName
        self.lastName = lastName
        self.netWorth = -10000
    }
    
    init(firstName: String, middleName: String, lastName: String){
        //give person a middle name
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        self.netWorth = -10000
    }
    
    func fullName() -> String {
        if let bindedMiddleName = middleName {
            return "\(firstName) \(bindedMiddleName) \(lastName)"
        } else {
            return "\(firstName) \(lastName)"
        }
    }
}

let person1 = Person(firstName: "John", lastName: "Doe")
let person2 = Person(firstName: "John", middleName: "A", lastName: "Seed")

//print(person1.fullName())

print(person1)

/*
 - `Equatable`
 - `Comparable`
 - `Hashable`
 - `Collection`
 - `Sequence`
 - `CustomStringConvertible`
 */
