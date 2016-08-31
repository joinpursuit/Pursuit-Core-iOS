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

