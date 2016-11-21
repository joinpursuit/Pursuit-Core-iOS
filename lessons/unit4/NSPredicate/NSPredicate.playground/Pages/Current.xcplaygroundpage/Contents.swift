//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


let tokyo = NSPredicate(format: "ANY locations == 'Tokyo'")
let tokyoMovies = movies.filter { tokyo.evaluate(with: $0) }
print (tokyoMovies)

