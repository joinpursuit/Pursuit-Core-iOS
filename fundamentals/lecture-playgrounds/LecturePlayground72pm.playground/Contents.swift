import UIKit

//one thing
var yup = true
var aNumber = 9

//collection of strings
var saySomething = "something"

//collection of some stuff
var tuple = (a: "firstThing",b: "secondThing")

//collection of numbers
var someRange = 0...12
someRange.contains(3)

//array - can have anything in it so long as they are all the same type!
var array = ["Malcolm","Olimpia","Angela","Rad","Bee","Liana"]

//count of items in the array is one more than the last index. Sooooooo the last index is one fewer than the count of items

//type annotation
var array: [String] = ["Malcolm","Olimpia","Angela","Rad","Bee","Liana"]

//same information as an tuple
var tupleOfSixStrings: (String,String,String,String,String,String) = ("Malcolm","Olimpia","Angela","Rad","Bee","Liana")

var tupleOfFiveStrings: (String,String,String,String,String) = ("Malcolm","Olimpia","Angela","Rad","Bee")
//type annotation with tuples means we have to explicitly tell the computer what type will be in *EACH* space


////take this array of numbers and print out the sum when you add all five numbers together
var arrayOfFiveInt = [1,2,3,4,5]

var sum = 0
for number in arrayOfFiveInt {
    sum += number
}
print(sum)//15
//or
print(arrayOfFiveInt.reduce(0,+))
//or
print(arrayOfFiveInt[0] + arrayOfFiveInt[1] + arrayOfFiveInt[2] + arrayOfFiveInt[3] + arrayOfFiveInt[4])

// we can add to sum the values from another array, so long as those values are the same type as sum
var arrayTwo = [2]
print(arrayOfFiveInt[0] + arrayOfFiveInt[1] + arrayOfFiveInt[2] + arrayOfFiveInt[3] + arrayOfFiveInt[4] + arrayTwo[0])


//how to find first character in a string
var string = "what is this string index stuff?"
string.first == string[string.startIndex]

var endIndex = string.endIndex
string.last == string[string.index(before: endIndex)]

//indexes in arrays! they're easier!

var array1 = [1,2,3,4,5]
array1.first == array1[0]
array1.last == array1[4] && array1.last == array1[array1.endIndex - 1]
