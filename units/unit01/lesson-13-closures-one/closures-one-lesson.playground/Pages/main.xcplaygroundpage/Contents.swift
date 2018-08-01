//: Playground - noun: a place where people can play

import UIKit

// closure defined using annotation
//var multiply: (Int, Int)->Int = { (x: Int, y: Int) -> Int in
//    return x * y
//}

//let z = 2
func doMathStuff(a: Int, b: Int, operation:(Int, Int)->Int) -> Int {
    return operation(a, b)
}

doMathStuff(4, b: 5, operation: {(a: Int, b: Int) -> Int in
    return a * b
})

doMathStuff(64, b: 26) { (a: Int, b: Int) -> Int in
    return a / b
}

doMathStuff(64, b: 26) { (a: Int, b: Int) -> Int in
    return a + b
}

//multiply(7, 8)


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
//let sorted = movies.sort { a, b in
//    if let a = a["year"] as? Int, b = b["year"] as? Int {
//        return a > b
//    }
//    return false
//}





