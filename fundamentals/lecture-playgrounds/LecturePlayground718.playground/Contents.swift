import UIKit

var str = "Hello, playground"


//Structs and Classes!
// things have properties (we all have two eyes)
// things have behaviors (we all go to the bathroom)

// we are creating a custom type (think of it like a category) and then later we will create instances (particular examples of that category)
//instances of structs/classes - refer to them as "objects"

//struct Dog {
    //four legs, wet noses, a tail (unless it's one of those breeds where they clip it... Olimpia disagrees)
    //stored properties
    //properties store information for the instance of the object in the same way that a variable in the global scope takes the value of whatever it's been instantiated by
//    let legs = 4
//    let isNoseWet = true
//    let tailQuality = "fluffy"
//}
//var dog1 = Dog()
//
////print(dog1)
//
//dog1.legs

//class Dog {}
let legs = 4
//print(legs)

//define a struct Elephant with 5 properties
struct Elephant {
    //these are all constants
    let tusks = 2
    let bigEars = 2
    let hasGoodMemory = true
    let trunk = 1
    //let's make this a property that can be changed
    var sizeDescription = "baby-sized"
}

var babar = Elephant()
//he is baby
print(babar.sizeDescription)
//our elephant grew up, so we changed the size description
//he is not baby
babar.sizeDescription = "big boi"

print(babar.sizeDescription)


//struct Dog {
//    //we can declare what the properties of a struct should be without giving an initial value
//    var name: String
//    let legs = 4
//    let isNoseWet = true
//    let tailQuality = "fluffy"
//}

//when we go to create a new instance of that struct, we have to provide to it the missing information for the properties that do not have values in the struct's definition
//var doggie1 = Dog(name: "spot")
//doggie1.name = "fido"
//var doggie2 = doggie1
//print(doggie2)
//doggie2.name = "some other dog name"

//structs are value types - something like string, int, other stuff
//var a = "a"
//var aAgain = a //it makes a copy of var a, and inserts the value of a into that copy
//a = "b" //i've updated a
//print(aAgain) //aAgain is value type, so it keep the original value that was assigned
//classes are reference types


//reference type: sam has a phone number. he gives it to alice.
// reference type: think of this as Bob and Alice both holding the piece of paper that the phone number is written on.
// value type: alice saves her own copy. Bob and alice both have their own unique copy of the phone number.



//if we only look at master on github, we are all ****referring**** to the same place. if we all fork a project from github, we all have our own place to look
var tailQuality = "not fluffy"
struct Dog {
    //we can declare what the properties of a struct should be without giving an initial value
    var name: String?
    let legs: String
    let isNoseWet = true
    let tailQuality = "fluffy"
    //let's make dog bark
    func bark() {
        print("woof woof, i am \(tailQuality)")
    }
    func poop() -> Int {
        return 12943
    }
}

var dog3 = Dog(name: nil, legs: "4")
dog3.name = "fido"
//print(dog3.name)
dog3.bark()
print("wow dog, you pooped \(dog3.poop()) times? that's a lot")
dog3.tailQuality

//take your elephant from before. give it three new behaviors. only one of them can be a print statement
//let's hear it for kary!!! go kary!!!

struct NewElephant {
    var teeth = 2
    let legs = 4
    let earSize = "big"
    let hasTrunk = true
    let skin = "grey"
    let solutionToHeat = "roll in mud"

    func smash() -> String {
        return  "smash"
    }
    //they roll in the mud when it's hot
    func hotPlay() -> String {
        return solutionToHeat
    }
    //this will kill it, likely. mutating is a keyword for an instance method that will allow us to call a function that changes the actual instance that we've called it on
    mutating func loseATooth() {
        if teeth > 0 {
            teeth -= 1
        }
    }
}

var iansElephant = NewElephant()
// iansElephant.tusks = iansElephant.tusks - 1
iansElephant.loseATooth()

struct Classroom {
    let diverse = true
    var temp = "cold"
    let startTime = "10am"
    var firstPersonToTalkToday: String?
    
    init(temp: String, firstPersonToTalkToday: String?) {
        self.temp = temp
        self.firstPersonToTalkToday = firstPersonToTalkToday
    }
    
    func learning() -> Bool {
        if temp == "cold" {
            print("can't, it's just too cold")
            return false
        } else {
            print("oh yeah absolutely")
            return true
        }
    }
}

var july18Class = Classroom(temp: "cold", firstPersonToTalkToday: "David")

print(july18Class.learning())
july18Class.temp = "warm"

print(july18Class.learning())


class SomeClass {
    //mutable property - you can change it
    var property1 = "can change"
    let property2 = "nope"
    var name = ""
    
    //when you go to create a new instance, you use init. init requires that by the end of the definition of that function,
    init(argument parameter: String){
        name = parameter
    }
    
    func smash() -> String {
        return "smash"
    }
}
