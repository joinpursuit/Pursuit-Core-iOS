import UIKit

var str = "Hello, playground"

// DRY - Don't Repeat Yourself.
// Separation of Responsibilities

    // Functions: block of code that we can call on elsewhere that runs the code that we defined. sometimes has parameters are arguments. sometimes has a specific type of return. what you write in it is unique to what's in it <--- if you declare variables in it, you can only use them within it (SCOPE)

func someFunction() {
    //the stuff it does
    //print something
    //compute something and return a value
    //some other stuff that we might have done, like transforming a hidden word based on some input from the user who enters that input in the terminal in, well, for example, a game like Hangman.
}

//functionality - what the code is going to do

//Closure - can be treated like any other type, such as an Int or a String.

// defining a function
//func (keyword) aFunction (name) () (might contain arguments) {
// (block of code)
//}

// creating a closure
// don't need a keyword. we also don't a need name. when a closure has no name, it's called an anonymous closure (unnamed block of functionality)


func someFunctionThatReturnsAnInt (argumentName parameterName: Int) -> Int {
    return parameterName
}

//that same function as a closure
let returnAnInt = {a -> Int in
    return a
}


let add = { (a: Int, b: Int) -> Int in //need keyword in at end of line
    return a + b
}
//OR
//let add: (Int, Int) -> Int = { (a,b) in
//    return a + b
//}

//we dont need to give argument names when passing values to a closure.
var sum = add(2,3)

print(sum)

//Class: come up with closures for subtraction, multiplication, division
let minus = { (c: Int, d: Int) -> Int in
    return c - d
}

let multi = { (e: Int, f: Int) -> Int in
    return e * f
}

let divide = { (g: Int, h: Int) -> Int in
    return g / h
}

let showMeC = { return "c" }

print(showMeC())
//same as
print({ return "c" }())

var arrayOfStrings = ["an","apple","fell","on","newton's ","head" ]

//mutates the array
arrayOfStrings.sort()

//does not mutate the original array. returns a new sorted array that must be saved to a variable to be used
arrayOfStrings.sorted()

func compareTwoStrings(a: String, b: String) -> Bool {
    return a > b
}

//Right now, we don't need to explicitly call a function, we just need to tell our `sorted` method that there's a block of code that we want to work in a specific way.
let sortedArrayUsingAFunction = arrayOfStrings.sorted(by: compareTwoStrings)

// the closure we know and love
let sortedArrayUsingClosure = arrayOfStrings.sorted(by: {(a: String, b: String) -> Bool in
    return a > b
})

//that same closure in one line of code
let sortedArrayUsingClosureInOneLine = arrayOfStrings.sorted(by: {(a: String, b: String) -> Bool in return a > b })

//that same closure without telling sorted what types we need (inferred)
let sortedArrayUsingClosureAndTypeInference = arrayOfStrings.sorted(by: { a, b  in return a > b })

//that same closure without telling it to return
let sortedArrayUsingClosureWithoutReturnCommand = arrayOfStrings.sorted(by: { a, b in a > b })

//that same closure without defining the values that we're using
//remember tuples: let tuple = (1,2)
//tuple.0
//tuple.1
let sortedArrayUsingClosureAndUnnamedValues = arrayOfStrings.sorted(by: { $0 > $1 })

//that same closure without any description of what's coming in.
let sortedArrayUsingClosureAndOperatorOnly = arrayOfStrings.sorted(by: > )

//that same closure but used in a different place
let sortedArrayUsingClosureOutsideOfArguments = arrayOfStrings.sorted() { $0 > $1 }

arrayOfStrings = ["an","apple","fell","on","newton's ","head" ]
//in comes a tuple of (Type, Type), out goes a Bool. So long as what happens in the block does that for me, the program won't protest.
let sortedArrayOfStrings = arrayOfStrings.sorted { $0 > $1 }

let arrayOfInts = [1,6,2,96,32]
let sortedArrayOfInts = arrayOfInts.sorted { $0 > $1 }

print(arrayOfStrings)
print(sortedArrayOfStrings)

let numbers = [32, 21, 33, 2, 66, 88, 43, 902, 73, 27, 905]
let words = ["One", "two", "Buckle", "my", "shoe"]

//define function applyKTimes that takes argument K as Int and takes another argument that is a closure, then performs the closure K number of times
//arguments are not named.
//parameters are K (an Int), closure (a closure that doesn't take any arguments and does not return anything aka is void)
func applyKTimes(_ k: Int, _ closure: () -> () ) {
    for _ in 0..<k {
        closure()
    }
}

let gimmeFive = {() -> Int in return 5}

print("this should print 5")
let five = gimmeFive()
print(five)

let printHello = { print("Hello Closures!") }
print("this should say hello once")
let theValue = printHello()
    //theValue is void
print(theValue)

print("this should say hello three times")
applyKTimes(3, { print("Hello Closures!") })

let nums = [32, 21, 33, 2, 66, 88, 43, 902, 73, 27, 905]
let ws = ["One", "two", "Buckle", "my", "shoe"]

//Sort numbers ascending.
//Sort words, descending case-insensitive.

//"a" > "A" is true

let numSorted = nums.sorted()
print(numSorted)
let wsSorted = ws.sorted {$0.lowercased() > $1.lowercased()}
print(wsSorted)

//Array functions! Work with any type in the array.
let newArrayOfInts = [10, 23, 12, 57, 82, 4, 421, 394, 42069, 1]

//map - returns an array where each element of the original array has been transformed in some way
//the closure in it: tells it what the new value of each element will be

let thoseIntsMultipliedByThree = newArrayOfInts.map({a -> Double in
    return Double(a) * 3.0
})
    
//closure is same as
//var newArray = [Double]()
//for n in newArrayOfInts {
//    let nDouble = Double(n) * 3.0
//    newArray.append(nDouble)
//}

//filter - returns an array with only the items that meet a condition within an array. it filters them ;)
//the closure in it: checks to see if something exists in the array, returns a Bool
let filteredArray = newArrayOfInts.filter({a -> Bool in
    return a % 3 == 0
})

print(filteredArray)
//reduce - with math: it combines up all the values in the array
//generally: it tries to combine all of the elements into one value, and returns that single value
//initial result: starting point for the stuff that we will do
//the closure in it: tells it what operation to perform

let reduceResultMultiplyingEachByThree = newArrayOfInts.reduce(0, { ($0 + $1) * 3 })

let reduceToFindLargestElement = newArrayOfInts.reduce(0, {x, y in
    //ternary operator -> condition ? true : false
    return x > y ? x : y
    // if x > y {return x}
    // else {return y}
})

print(reduceToFindLargestElement)



