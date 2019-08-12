import UIKit

var str = "Hello, playground"

//type conforms to a protocol

protocol Cook {
    func makeFood()
}

struct Parent: Cook {
    func makeFood() {
        print("come and get it")
    }
}

struct Pizzamaker: Cook{
    func makeFood() {
        print("spicy meatball pizza on its way")
    }
}

struct Kid {
    let name: String
    //could name this whatever i want, but it's best not to
    var parentDelegate: Parent?
    var pizzaDelegate: Pizzamaker?
}

var olimpia = Parent()
var rad = Pizzamaker()
var ermis = Kid(name: "Ermis", parentDelegate: olimpia, pizzaDelegate: rad)
ermis.parentDelegate?.makeFood()
ermis.pizzaDelegate?.makeFood()
