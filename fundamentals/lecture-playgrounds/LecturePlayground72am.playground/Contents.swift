import UIKit

//Strings Day 2

//What's Unicode?
//ex: Unicode of one character in two different ways
var unicodeSomething = "\u{00cd}"
print(unicodeSomething)
var unicodeSomethingElse = "\u{0049}\u{0301}"
print(unicodeSomethingElse)

//canonical equivalence - the agreed-upon meaning.
//comparing values of the two scalars
//uses Cocoa library to check if these scalars are the same value

print(unicodeSomething == "Í")

//there's a scalar for a tree??
//2698 is its value.

var accentedTree = "\u{2698}\u{0301}"
print(accentedTree)

var diffAccentedTree = "\u{2698}\u{00b4}"
print(diffAccentedTree)

//let's look at the scalars in a thing
var a = "Í"
print(a.unicodeScalars.shuffled())
print(a.unicodeScalars.sorted())

////flower box question from Strings lab 1

var flower = "\u{2698}"
var verticalSymbol = "\u{007c}"
var horizontalSymbol = "\u{005f} "

for _ in 1...11 {
    print(horizontalSymbol, terminator: " ")
}
print()
print()
for _ in 1...7 {
    print("\(verticalSymbol) \(flower) \(verticalSymbol) \(flower) \(verticalSymbol) \(flower) \(verticalSymbol) \(flower) \(verticalSymbol) \(flower) \(verticalSymbol)")
}
for _ in 1...11 {
    print(horizontalSymbol, terminator: " ")
}

////or

var flower = "\u{2698}"
var verticalSymbol = "\u{007c}"
var horizontalSymbol = "\u{005f} "
let outline = String(repeating: horizontalSymbol, count: 11)
print(outline)
for _ in 1...7 {
    for _ in 1...5 {
        print("\(verticalSymbol) \(flower)", terminator: " ")
    }
    print(verticalSymbol)
}
print(outline)

why is a string not an array?
var array = [1,2,3,4]
print(array[0])

var myString = "this is a collection of characters"
print(myString[0]) //doesn't work!!

//can't directly look at the place of a character to find index, like we can with arrays
//instead, we're going to have to use the type String.Index

print(myString.startIndex) //prints String.Index

let myStringStart = myString.startIndex
print(myString[myStringStart]) //prints character

myString.last //returns a Character
myString.endIndex //returns String.Index

var someWhereInside = myString.index(myStringStart, offsetBy: 2)
print(myString[someWhereInside])

var newString = myString.endIndex
var indexBeforeEnd = myString.index(before: newString)
print(myString[indexBeforeEnd])
//remember that endIndex is one beyond our last index ("out of bounds")


//string equivalence??
let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"

print(eAcuteQuestion)
print(combinedEAcuteQuestion)

print(eAcuteQuestion == combinedEAcuteQuestion)
