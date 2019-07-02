import UIKit

let projectorWorks = true
let projectorDoesntWork = false

if projectorDoesntWork == false {
    print("let's do some learnin")
}

//we don't need to check "== false" since the if-statement is looking for a boolean value
if projectorDoesntWork {
    print("what's going on")
}

var weather = 83

if weather >= 75 {
    print("wear a t-shirt")
} else if weather <= 32 {
    print("wear a coat")
} else {
    print("whatever you want")
}


var grade = 85
var good = 90
var medium = 70

if grade >= good {
    print("excellent!!!")
} else if grade >= medium {
    print("okay? eh")
} else {
    print("not great bob")
}

//ternary
var thingToPrint = grade >= good ? "great job" : "not great job"
print(thingToPrint)

var whatToWear = weather >= 65 ? "wear a shirt" : "wear a sweater"

//switch
var grade = 85
var good = 90
var medium = 70

switch grade {
    case good:
        print("ya did good!")
    case medium:
        print("this was okay but needs improvement")
    default:
        print("not great bob")
}

//the switch above is logically equivalent to the if/else if/else sequence below
if grade == good {
    print("ya did good!")
} else if grade == medium {
    print("this was okay but needs improvement")
} else {
    print("not great bob")
}

var weather = 29
var goodWeather = 75..<85
var badWeather = Range(0...45)
//or
var badWeather = 0...45

switch weather {
    case goodWeather:
        print("it's nice out!")
    case badWeather:
        print("don't go out")
    default:
        print("whatever")
}

//don't need default case when the options have been exhausted
//ex: a bool can have only two values
var thisCanBeTwoThings = true
switch thisCanBeTwoThings {
    case true:
        print("yup")
    case false:
        print("nope")
}


var david = (age: 30,dob: "april 22 1989",work: "somewhere", dsomething: "fddfs", somfhdkf: "fdsaa")
print(david.)
print(david.2)
