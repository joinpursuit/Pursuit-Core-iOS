import UIKit

//Given the 4 arrays of Ints below, create a new array, sorted in ascending order, that contains all the values without duplicates.

let arr1 = [2, 4, 5, 6, 8, 10, 12]
let arr2 = [1, 2, 3, 4, 5, 6]
let arr3 = [5, 6, 7, 8, 9, 10, 11, 12]
let arr4 = [1, 3, 4, 5, 6, 7, 9]

//using sets
//turn these arrays into sets (using casting to Set<Int>)
//combine them all (using .union)
//why is union important? it will take out the duplicates (make sure there's only one of each value)
//so once all have been combined, turn that back into an array
//use .sorted to put these Ints in ascending order (aka, from low to high)

var arrayOfArrs = [arr1, arr2, arr3, arr4]
var answerArr: [Int] = []
var setArr: Set<Int> = []

for i in arrayOfArrs {
//    let set = Set(i)
//    setArr = setArr.union(set)
// OR
    setArr = Set(i).union(setArr)
}

//answerArr = Array(setArr)
//print(setArr.sorted())

//with only knowledge of arrays, we could have created that new array, then looped through each of the arrays defined above (arr1 - arr4) and added values to the new array if they didn't exist in that array already.
/*
 for array in arrayOfArrs{
 for int in array {
 //add in a value if it is unique/does not exist in the new array that we are creating in this block right here inside the nested for loop
 }
 }
 */

//functions define some behavior that we will want to use. they don't execute that behavior until later on when we call them.

func printSomethingAnnoyingOneThousandTimesWithAForLoop() {
    for _ in 0..<1000 {
        print("some annoying thing")
    }
}

func printThatThingAboveFiveThousandTimes() {
    printSomethingAnnoyingOneThousandTimesWithAForLoop()
    printSomethingAnnoyingOneThousandTimesWithAForLoop()
    printSomethingAnnoyingOneThousandTimesWithAForLoop()
    printSomethingAnnoyingOneThousandTimesWithAForLoop()
    printSomethingAnnoyingOneThousandTimesWithAForLoop()
    //OR
    //for _ in 0...4 {
    //  printSomethingAnnoyingOneThousandTimesWithAForLoop()
    //}
}

func addTwoToAnIntAndPrintTheResult(x: Int) {
    let changedX = x + 2
    print(changedX)
    // i want to add 3 to that original Int taht came in (the argument x)
    
}

addTwoToAnIntAndPrintTheResult(x: 5)

//var someNumberMaybe = addTwoToAnIntAndPrintTheResult(x: 5)
//
//print(someNumberMaybe)

func addTwoToAnIntAndReturnTheResult(numberToBeAdded x: Int) -> Int {
    let changedX = x + 2
//    print(changedX)
    //must return the type that we define above
    return changedX
    // i want to add 3 to that original Int taht came in (the argument x)
}

addTwoToAnIntAndReturnTheResult(numberToBeAdded: 5)

//this var saves the return value that we get from calling this function
var thisShouldReturnAnInt = addTwoToAnIntAndReturnTheResult(numberToBeAdded: 5)
//var something = 7

print(thisShouldReturnAnInt)

func thisReturnsSix() -> Int {
    return 6
}

var thisShouldBeSix = thisReturnsSix()

func weWillAddSomeToAString(argument parameter: String) -> String {
    let newString = parameter + "some"
    return newString
}

var w = weWillAddSomeToAString(argument: "a string")

// define and call a function called multiplyAnIntTimesThreeAndPrints that takes in an Int and prints out three times that Int (hint: there is no return value)

// define a function called showMeThatThreeTimes that calls multiplyAnIntTimesThreeAndPrints three times (hint: there is no *still* return value)

// define a function (you name it!) that takes in a string and returns that string in reverse character order (hint: there IS a return value).

//call all three functions you've created
