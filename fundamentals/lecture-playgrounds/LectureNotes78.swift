 import UIKit

var temp: Double?
if temp != nil {
    print(temp)
} else {
    print("the system is broken")
}

var name: String? = "alan"
var optionalInt: Int? = 40
var enrolled: Bool? = true

var lastName = "dafd"
print(name! + lastName )
print(optionalInt! + 4)

var firstWord: String = "42"
var secondWord = "alex"
var thirdWord: String?

thirdWord = nil
firstWord = nil
firstWord = thirdWord
thirdWord = secondWord
print(thirdWord)

var myPet: String?
var myFavoriteFood: String?
if var favFood = myFavoriteFood {
    favFood = "pizza"
    print("My favorite food is \(favFood)")
} else {
    myFavoriteFood = "pizza"
    print("no food")
}

print(myFavoriteFood)
//print "my favorite food in the world is ____ "


if var unwrappedPet = myPet {
    print(unwrappedPet)
    print(unwrappedPet + "askndkajsn")
} else {
    myPet = "Dog"
    print(myPet!)
}

var hoursOfOperations: String?
var ratings: Int? = 34

if let unwrappedHours = hoursOfOperations {
    if let unwrappedRatings =  ratings {
        print(unwrappedRatings + unwrappedHours)
    }
    print(unwrappedHours)
}

if let unwrappedHours = hoursOfOperations,
    let unwrappedRatings = ratings {

}


var myOptionalArray: [String] = ["Alan","alex","dog"]
while let unwrappedName = myOptionalArray.popLast() {
    print(unwrappedName)
}

for i in  0...2 {
    print(myOptionalArray.popLast())
}

var myAge: Int?
for i in 0...1 {
guard let unwrappedAge = myAge else {
    print("we didnt do it")
    break
}
print("we did it")
}


var doWeNeedBreak: Bool?
var unwrappedBreak = doWeNeedBreak ?? true
print(unwrappedBreak)


//nil coalescing
var temp: String? = "30"
var unwrappedTemp = temp ?? "temperature not found"

print(unwrappedTemp)

if let unwrappedTemp = temp {
    if let integerVersion = Int(unwrappedTemp) {
        print(integerVersion + 5)
    }
}
