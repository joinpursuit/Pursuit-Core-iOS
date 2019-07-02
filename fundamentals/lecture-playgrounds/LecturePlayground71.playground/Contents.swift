import UIKit

//Write code that prints out all the points in the area bounded by (0,0), (10,0), (0,10) and (10,10) where x and y are both integers.

//let xRange = 0...10 ---> why didn't we need two ranges?
let yRange = 0...10
//var yRange = xRange ---> why didn't we use this?

//prints a tuple!!
for a in yRange {
    for b in yRange {
        let tuple = (a,b)
        print(tuple)
        /*
         order (a,b)
         (0, 0)
         (0, 1)
         (0, 2)
         order (b,a)
         (0, 0)
         (1, 0)
         (2, 0)
         */
    }
}

// prints a string!
for a in yRange {
    for b in yRange {
        print("(\(a),\(b))", terminator: " ")
    }
    print("")
}

//let's talk about strings!!!

//they have quotation marks
//they contain/are made up Characters
//when we compare them, it compares the first characters in order ---> "abcde" > "abcdd"
//can count how many values are in the string
//"" <--- empty string!

//string interpolation ---> adding a the value of variable "a" into a string using \(a)

//Unicode ->> standardized system for characters

var someString = "Some string"
var emptyString = String()

let newString = String("some stuff")
let otherString = String(stringLiteral: "a string that we're typing in")
let newishString = String(repeating: "b", count: 3)

////append = add this to the end
someString.append(contentsOf: " add me")
someString += " and add me again"

print(someString)
print(newishString)

//first, create a string (it can be anything)
//then create an integer
//then, in one step, use string interpolation to append the value of the integer and the phrase " and my number is _______" to your string

var someString = "and my number is "
var someNumber = 100
someString.append(contentsOf: " \(someNumber)")
print(someString)

let firstString = "my favorite animal is the elephant"
let favNumber = 7
var stringUno = " and my favorite number \(favNumber)"
print(firstString + stringUno)


//iterable: what's some stuff we know about it
//loosely, anything that can be counted/anything we can look through all the members of
//anything that could be repeated over and over
//anything that we can look through all the elements/members/indexes of

//ex: range is iterable collection of numbers
for b in 1...10 {
}

//ex: array is iterable
for a in ["a","b","c"] {
}

//note: tuple can be iterated over if we create a way to do it

//strings are also iterable!!1
//for c in "i'm really hungry" {
    print(c)
}

var davidStatus = "i'm also really hungry"
print(davidStatus.count)

////print --> the string above but every letter is upper case.
var beeStatus: String = "i need food"
print(beeStatus.uppercased())

////print --> same string but we got rid of the first letter/Character of the string
print(beeStatus.dropFirst())

//why is the below a different value than beeStatus.dropFirst()
//beeStatus = String(beeStatus.dropFirst())
print(beeStatus)

////print --> same string but in reverse order

print(String(beeStatus.reversed()))
//or
var theStringWeWillEndUpWith = ""
for b in beeStatus {
    theStringWeWillEndUpWith = "\(b)" + theStringWeWillEndUpWith
}

//note: we can combine together String's (or other types') methods
print(beeStatus.uppercased().lowercased().count)

print(theStringWeWillEndUpWith)

if theStringWeWillEndUpWith is String {
    print("string")
} else {
    print("not string")
}
