//: [Previous](@previous)

import Foundation

let ints = [4,2,6,3,4,6,2,8,5]


func myFilter(inputArray: [Int], filter: (Int) -> Bool) -> [Int] {
    var outputArray = [Int]()
    for val in inputArray {
        if filter(val) {
            outputArray.append(val)
        }
    }
    return outputArray
}


myFilter(ints) { (a) -> Bool in
    a % 2 == 0
}

func myMap(inputArray: [Int], map: (Int) -> String) -> [String] {
    var outputArray = [String]()
    for val in inputArray {
        outputArray.append(map(val))
    }
    return outputArray
}

