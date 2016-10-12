//: Playground - noun: a place where people can play

import UIKit

enum ErrorCode {
    case BadInput
    case NoNetwork
    case FileNotFound
}

let code = ErrorCode.NoNetwork



enum CardinalDirection {
    case North
    case South
    case East
    case West
}


enum UserMessage: String {
    case Greeting = "Hello good person!"
    case Farewell = "Fare thee well, come again."
    case Prompt = ">>>"
}
//
//let greeting = UserMessage.Greeting
//print(greeting.rawValue)

// raw values
//enum NYCBoro: String {
//    case Queens = "Queens"
//    case Brooklyn = "Brooklyn"
//    case Manhattan = "Manhattan"
//    case Bronx = "Bronx"
//    case StatenIsland = "Staten Island"
//}
//
//let boro = NYCBoro.StatenIsland
//boro.rawValue
//
//let userInput = "Bronx"
//print(userInput)
//if let userBoro = NYCBoro(rawValue: userInput) {
//    switch userBoro {
//    case .Queens:
//        print("Correct answer")
//    default:
//        print("You chose...poorly")
//    }
//    print(userBoro.rawValue)
//}
//
//enum CompassPoint: String {
//    case North, South, East, West
//}
//
//let point = CompassPoint.East
//point.rawValue
//
//enum Planet: Int {
//    case Mercury = 100, Venus, Earth, Mars = 200, Jupiter, Saturn, Uranus, Neptune
//}
//
//var planet = Planet.Jupiter
//print("planet: \(planet.rawValue)")
//
enum HttpErrorCode: Int {
    case BadRequest = 400, Unauthorized, PaymentRequired, Forbidden, NotFound, MethodNotAllowed, NotAcceptable, ProxyAuthenticationRequired, RequestTimeout, Conflict
}
var error = HttpErrorCode.Conflict
error = .NotFound


let requestStatus = 400
switch requestStatus {
case 404:
    print("Page not found")
case 400:
    print("Bad Request")
default:
    print("Unknown error")
}

if let errorCode = HttpErrorCode(rawValue: requestStatus) {
    switch errorCode {
    case .BadRequest, .Forbidden:
        print("Bad Request or Forbidden")
    case .NotFound:
        print("Page not found")
    default:
        break
    }
}
else {

}



// associated values
enum Instrument {
    case Trumpet(Double, String, Int) // key, number of valves
    case Guitar(String, String, String, String, String, String)
    case Violin(String, String, String, String)
    case Cello(String, String, String, String)
}

let trumpet = Instrument.Trumpet(440.0, "B♭", 3)
let piccoloTrumpet = Instrument.Trumpet(880.0, "C", 4)
let guitar = Instrument.Guitar("E", "A", "D", "G", "B", "E")
let droppedD = Instrument.Guitar("D", "A", "D", "G", "B", "E")

var instrument = droppedD

switch instrument {
case let .Guitar(first, second, third, fourth, fifth, sixth):
    print("Guitar, tuned: \(first)\(second)\(third)\(fourth)\(fifth)\(sixth)")
case let .Trumpet(pitch, key, valves):
    print("Trumpet, key: \(key), valves: \(valves)")
    break
case let .Violin(first, second, third, fourth):
    print("Violin, tuned: \(first)\(second)\(third)\(fourth)")
    break
case let .Cello(first, second, third, fourth):
    print("Cello, tuned: \(first)\(second)\(third)\(fourth)")
    break
}

switch instrument {
case .Trumpet:
    break
default:
    break
}


