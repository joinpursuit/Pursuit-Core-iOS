import UIKit

var str = "Hello, playground"


//type properties
var p = Double()
p = 3.14
var pi = Double.pi
Date()

var array = [1,2,4,3,75]
//sorts the array itself (mutates array)
//array.sort()
//returns a new array that has the sorted values
var sortedArray = array.sorted()

class IDK {
    let confused: Bool
    let drowsy: String
    var temp: String
    
    //function definition for creating a new instance
    init(temp: String, drowsy: String, confused: Bool) {
        self.temp = temp
        self.drowsy = drowsy
        self.confused = confused
    }
    func ululate() {
        if self.confused {
            print("I HAVE NO IDEA.")
        } else {
            print("I got this.")
        }
    }
    func getWarmer() {
        temp = "really hot"
    }
}

struct DavidStruct {
    var david: String
}

//instances of classes that are saved as constants
let leviKnows = IDK(temp: "too damn hot", drowsy: "nah i'm good", confused: false)
let istishnaDK = IDK(temp: "content", drowsy: "i could sleep", confused: true)
leviKnows.temp = "too hot"

//instance of a struct that is also saved as a constant
let newStruct = DavidStruct(david: "something... i'm kinda lost here")
//cannot change because struct is a constant and is now static
//newStruct.david = "david"

//istishnaDK.ululate()
//leviKnows.ululate()
//a constant instance of a class can mutate properties of itself, whereas a constant instance of a struct cannot.
leviKnows.getWarmer()

//can't change instance itself if it's constant.
//won't work: leviKnows = istishnaDK

class Vehicle {
    var size: Double
    var make: String
    
    init(size: Double, make: String) {
        self.size = size
        self.make = make
    }
    
    func drive() {
        print("moving")
    }
}

let newVehicle = Vehicle(size: 6.8, make: "Ford")

//newVehicle.drive()

class Car: Vehicle {
    //inherits size (Double) and make (String)
    var wheels = 4
    var numOfPassengers: Int
    
    init(size: Double, make: String, numOfPassengers: Int) {
        //when we use properties from super, do we have to use super to let it know we're taking properties from it????
        //it doesn't like what you're doing
        //is it referencing the superclass of cars?
        self.numOfPassengers = numOfPassengers
        super.init(size: size, make: make)
    }
    
    func tellMeYourCapacity() {
        print("I can carry \(numOfPassengers) passengers")
    }
    
    //cars vroom vroom
    override func drive() {
        print("vroom vroom")
    }
}

let newCar = Car(size: 20.2, make: "Cool Car Co", numOfPassengers: 5)

//newCar.drive()

//class for airplanes. they are a subclass of vehicle. they must have 3 new properties, they must have two new instance methods, and one of those instance methods must be mutating

class Airplane: Vehicle {
    var company = String()
    var speed: Double
    //getter - how we receive a value (how we get it!)
    //setter (breeds of dog) but also is how we give this thing (a variable in our case) a new value
    //the manufacturer's info
    var capacity: Int
    //what we'll tell consumers
    //computer property - its value isn't stored, but instead it refers to another thing
    var lieWeTellAboutCapacity: Int {
        //getter - if it's alone, is called "read-only"
        get {
            return capacity - 5
            //return a value of the type Int
        }
        set {
            capacity = newValue + 5
        }
        //setter
    }
    
    init(size: Double, make: String, company: String, speed: Double, capacity: Int) {
        self.company = company
        self.speed = speed
        self.capacity = capacity
        super.init(size: size, make: make)
    }
    
    func takingoff(input: String) -> String {
        var takingOffMessage = input
        print(takingOffMessage)
        return takingOffMessage
    }
    
    override func drive() {
         print("sfgosifhgsfighshjjjs")
    }
    
    func changeCompany(newCompany: String){
        company = newCompany
        printChangedCompanyMessage(newCompany: newCompany)
    }
    
    private func printChangedCompanyMessage(newCompany: String) {
        print("Your new airline is \(newCompany)")
    }
}

let jetbluePlane = Airplane(size: 4, make: "747", company: "Jet Blue", speed: 500, capacity: 400)

//print(jetbluePlane)
//jetbluePlane.drive()
//print(jetbluePlane.company)
//jetbluePlane.changeCompany(newCompany: "Southwest")
//print(jetbluePlane.company)

jetbluePlane.lieWeTellAboutCapacity
jetbluePlane.lieWeTellAboutCapacity = 227

var newVar = 12
print(newVar)
newVar = 13

