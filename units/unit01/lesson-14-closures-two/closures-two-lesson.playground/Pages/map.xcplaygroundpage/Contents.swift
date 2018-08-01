//: Playground - noun: a place where people can play

import UIKit


let ints = [4,2,6,3,4,6,2,8,5]

ints.filter { (a) -> Bool in
    a % 2 == 0
}


ints.map { (a) -> String in
    if a > 3 {
        return "Greater"
    }
    else {
        return "Lesser"
    }
}


