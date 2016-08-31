//: Playground - noun: a place where people can play

import UIKit

// closure defined using annotation
var noParameterAndNoReturnValue: () -> () = {
    print("string")
}
noParameterAndNoReturnValue()


// example of closing over the variables from environment
var number = 0

var addOne = {
    number += 1
}

print(addOne())
addOne()
addOne()
addOne()
addOne()
print(number)



func sum(from: Int, to: Int, f: (Int) -> (Int)) -> Int {
    var total = 0
    for i in from...to {
        total += f(i)
    }
    return total
}

sum(1, to: 10) {
    $0
} // the sum of the first 10 numbers

sum(1, to: 10) {
    $0 * $0
} // the sum of the first 10 squares

func applyKTimes(K: Int, _ closure: () -> ()) {
    for _ in 1...K {
        closure()
    }
}

applyKTimes(5) {
    print("hi")
}


// sort the movies
let sorted = movies.sort { a, b in
    if let a = a["year"] as? Int, b = b["year"] as? Int {
        return a > b
    }
    return false
}


var doubler = { (a: Int) -> Int in
    return a * 2
}

print(doubler(22))

var number = 0
var addOne = {
    number += 1
}
addOne()
addOne()
print(number)


