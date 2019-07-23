import UIKit

var str = "Hello, playground"

//memberwise initialization
struct GoodQuestion {
    var text = "Not sure", feelsReadyForThisMorning = false
    mutating func getMadAtQuestion(text: String) {
        self.text = text
    }
    func answerQuestion(answer: String) -> Bool {
        return self.text == answer
    }
}

let aString = "Here's some message"
//can't change the value of a constant struct
//wont work -> aString.append(contentsOf: " i hope")

let newQuestion = GoodQuestion(text: "What's going on", feelsReadyForThisMorning: false)
let strongQuestion = GoodQuestion(text: "What is memberwise initialization?", feelsReadyForThisMorning: true)
//let questioningQuestion = GoodQuestion(text: "Still unsure what's going on")
var originalQuestion = GoodQuestion()
originalQuestion.answerQuestion(answer: "Not sure")
originalQuestion.getMadAtQuestion(text: "I am sure")
originalQuestion.answerQuestion(answer: "Not sure")


class Animal {
    var mammal: Bool
    var hair: Bool
    
    init(mammal: Bool, hair: Bool) {
        self.mammal = mammal
        self.hair = hair
    }
    func makeNoise(){
        print("gurgle")
    }
}

//create  a superclass for Dog that has two properties and an instance method that Dog will inherit

class Dog: Animal {
    var legs = 4
    var isFixed = false
    var name: String
    
    //designated initializer
    //made it private so someone using the Dog class won't get confused or use it wrong
    private init(name: String, mammal: Bool, hair: Bool) {
        self.name = name
        //trying to use a property from superclass before initializing super class
        //subclass inherits properties of superclass - until we call the superclass's init, we do not have access to its properties.
        //will not work -> self.hair = hair
        super.init(mammal: mammal, hair: hair)
    }
    
    //convenience initializer
    //we already know dogs have hair and are mammals
    convenience init(name: String){
        self.init(name: name, mammal: true, hair: true)
    }
    
    override func makeNoise() {
        print("woof")
    }
}

let myNewPup = Dog(name: "Mushroom")

//1. Designated initializer must call the designated initializer from its superclass

//2. Convenience initializer must call another initializer from the same class (convenience initializer does not itself initialize the instance)

//3. Convenience initializer must ultimately call a designated initializer

class Person {
    var name: String
    //this can only be used/referred to in the scope of this definition
    private var age: Int
    var ageYouTellPeople: Int {
        get { if age > 65 { return age - 6 }
        else if age < 21 && age >= 17 { return 21 }
        return age }
    }
    init(name: String, age: Int) {
        self.name = name; self.age = age
    }
    func tellYourName() { print(name) }
}

//Create a subclass of Person called President, which has a convenience initializer and an override for tellYourName and a new instance method AND!!!!!! two new properties, one of which is a computed property

let iram = Person(name: "Iram Fattah", age: 25)
iram.ageYouTellPeople

class President: Person {
    var twoTerms: Bool
    var numYearsInOffice: Int {
        get {
            return twoTerms ? 8 : 4
//            same as if {
//                return 8
//            }
//            return 4
        }
    }
    
    private init(twoTerms: Bool, name: String, age: Int) {
        self.twoTerms = twoTerms
        //self.name = name -> won't work, need to bring in superclass's properties
        super.init(name: name, age: age)
        //self.name = name -> this will work, if you want to do it
    }

    convenience init(age: Int, name: String){
        self.init(twoTerms: false, name: name, age: age)
    }
    
    override func tellYourName() {
        print("Hi. I am \(name) and I am the president.")
    }
    
    func tellMeYourAge() {
        print("My age is \(ageYouTellPeople)")
    }
}

let newPrez = President(age: 11, name: "The President")

struct Rectangle {
    var width: Int
    var height: Int
    var ratio: Int {
        get {
            return height/width
        }
        set {
            height = width * newValue
        }
    }
    
    init(width: Int) {
        self.height = 13
        self.width = width
    }

    init(width: Int, ratio: Int){
        self.width = width
        self.height = width/ratio
    }
}

var square = Rectangle(width: 12)
square.ratio = 2
//once we create init functions for a struct, we no longer have the option to initialize it using memberwise initialization
//can't use this unless we define an init with arguments `width` and `height` ->>>> let square2 = Rectangle(width: <#T##Int#>, height: <#T##Int#>)
