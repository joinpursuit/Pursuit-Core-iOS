//: [Previous](@previous)

import Foundation


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
    case "^":
        return {x, y in pow(x, y)}
    case "badpow":
        return {(x:Double, y:Double) -> Double in
            var base = Double(1)
            for _ in 1...Int(y){
                base *= x }
            return base}
    case "//":
//        return {x, y in Double(Int(x) / Int(y)) }
        return {x, y in floor(x/y) }
    default:
        return {x, y in x + y }
    }
}

let plus = mathStuffFactory("+")
plus(3, 8)

let intDiv = mathStuffFactory("//")
intDiv(3, 2)

let badPow = mathStuffFactory("badpow")
badPow(2.4,3.6)

let goodPow = mathStuffFactory("^")
goodPow(2.4, 3.6)

