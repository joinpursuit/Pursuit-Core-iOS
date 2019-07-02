import UIKit

var str = "Hello, playground"

//iterate through a range
let numbers = -1...3
var sum = 0

for i in numbers {
    sum += i
}

print("i have \(sum) cards in my hand")

//let's look at an array, which we might know a tiny bit about
let numbers = [-1,0,3,1,2]
var sum = 0

//do some stuff to get through the array numbers in a loop

for eachNumberInNumbers in numbers {
    sum += eachNumberInNumbers
    //this is the same as: sum = sum + eachNumberInNumbers
    //let's look at the math each time we go through the loop:
    //1st time: 0 + -1 = -1
    //2nd time: -1 + 0 = -1
    //3rd time: -1 + 3 = 2
    //4th time: 2 + 1 = 3
    //5th time: 3 + 2 = 5
}

print("i have \(sum) cards in my hand")

//using where to add a condition
let someRange = 0...11
for aNumberThatMightBeEven in someRange where aNumberThatMightBeEven % 2 == 0  {
    print(aNumberThatMightBeEven)
}

//using an if-statement inside the loop is a little different, because it will iterate over the entire range, whereas the loop with a where condition only iterates over the even numbers
for aNumberThatMightBeEven in someRange  {
        if aNumberThatMightBeEven % 2 == 0 {
            print(aNumberThatMightBeEven)
        } else {
            print("that's odd")
        }
}


let arrayOfNames = ["fredlyne","kary","kevin","david"]
////create a for-loop that prints a name if it isn't an instructor
var instructor = "david"

for eachPersonInArray in arrayOfNames where eachPersonInArray != instructor {
    print(eachPersonInArray)
}

//while loops
while true {
    //infinite!!! goes forever
    print("something")
}

//iterates only once
var doIt = true
while doIt {
    doIt = false
    //do some stuff
}

var anyNumber = 11
while anyNumber > 10 {
    print(anyNumber)
    anyNumber -= 1
}

//continue
var rangeOfNumbers = 0...10
var index = 5
while rangeOfNumbers.contains(index) {
    if index > 3 {
        index -= 1
        continue
    }
    print(index)
    index -= 1
}

//nested loop
for i in 1...5 {
    for j in 1...5 {
        print("\(i),\(j)", separator: "", terminator: " ")
    }
    print("")
}
