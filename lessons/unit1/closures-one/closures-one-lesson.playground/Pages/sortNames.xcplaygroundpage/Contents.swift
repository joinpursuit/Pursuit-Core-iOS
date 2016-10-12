//: [Previous](@previous)

import Foundation

//public let firstAndLastTuples = [("Johann S.", "Bach"),
//                                 ("Claudio", "Monteverdi"),
//                                 ("Duke", "Ellington"),
//                                 ("W. A.", "Mozart"),
//                                 ("Nicolai","Rimsky-Korsakov"),
//                                 ("Scott","Joplin"),
//                                 ("Josquin","Des Prez")]


print(firstAndLastStrings.sort {(a, b) -> Bool in
    return a < b
    })

print(firstAndLastTuples.sort {(a, b) -> Bool in
    return a.0 < b.0
    })

print(firstAndLastStrings.sort {(a, b) -> Bool in
    let a_words = a.componentsSeparatedByString(" ")
    let b_words = b.componentsSeparatedByString(" ")
    
    return a_words.last! < b_words.last!
    })

let badWords = ["heck", "darn", "drat", "fudge"]
let text = "What the heck we s'posed to do you darn fool. Drat that cat. Oh fudge."

let newText = text.componentsSeparatedByString(" ").map { (s) -> String in
    switch s {
    case "heck":
        return "horkin'"
    case "darn":
        return "dorkin'"
    case "drat":
        return "drattin'"
    case "fudge":
        return "fork"
    default:
        return s
    }
}

print(newText)


//9.  Write a function that takes a function as input and returns a function that doubles the output of the input function

//Input: (Int) -> Int
//Output: (Int) -> Int

func doublerFactory(funk: (Int)->Int) -> (Int) -> Int {
    return {(a: Int) -> Int in
        return 2 * funk(a)
    }
}

let f = doublerFactory { (x: Int) -> Int in
    return x * x
}

f(4)

func mathStuffFactory(opString: String) -> (Double, Double) -> Double {
    switch opString {
    case "+":
        return {x, y in x + y }
    case "-":
        return {x, y in x - y }
    case "*":
        return {x, y in x * y }
    case "/":
        return {x, y in x / y }
    default:
        return {x, y in x + y }
    }
}

let times = mathStuffFactory("*")
times(4,3)

let someInts = [1, 2, 3]
someInts.map { (a) -> Int in
    return a * 2
}
someInts.map { (a) -> String in
    return String(a)
}

someInts.filter { (a) -> Bool in
    return a % 2 == 1
}
