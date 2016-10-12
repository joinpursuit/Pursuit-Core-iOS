# Standards
Use functions to solve problems

# Objectives
* Articulate what a closure is and why a function is a type of closure
* Use closure expression syntax
* Solve problems by using functions that take functions as an argument

### Vocabulary: closure, block,  algorithm, sort, lambda function, maintenance, higher-order

# Resources
Swift Programming: The Big Nerd Ranch Guide, Chapter 13 Closures

Apple's [Swift Language Reference, Closures](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html#//apple_ref/doc/uid/TP40014097-CH11-ID94)

# Assessment Materials
## Midday Check-in and solutions

# Lecture

## Warm up

Let's look at that nested function we didn't get to yesterday.

```swift
func reportOnMovies(movies:[[String:Any]], language: String = "en") -> String? {
    var wordForAnd = "and"
    
    switch language {
    case "en":
        wordForAnd = "and"
    case "sp":
        wordForAnd = "y"
    default:
        break
    }
    
    func buildCommaSeparatedList(words: [String]) -> String {
        var output = ""
        for (i, word) in words.enumerate() {
            if i == words.count - 1 {
                output += "\(wordForAnd) \(word)"
            }
            else {
                output += "\(word), "
            }
        }
        return output
    }
    
    var output: String?
    for movie in movies {
        if let name = movie["name"] as? String, year = movie["year"] as? Int,
            cast = movie["cast"] as? [String], locations = movie["locations"] as? [String] {
            if output == nil {
                output = ""
            }
            
            let castString = buildCommaSeparatedList(cast)
            
            output?.appendContentsOf("\(name) came out in \(year) starring \(castString).")
            output?.appendContentsOf("\nIt was shot in \(buildCommaSeparatedList(locations)).")
            if let president = presidentsByYear[year] {
                output?.appendContentsOf(" \(president) was president.\n")
            }
            output?.appendContentsOf("\n")
        }
    }
    return output
}

print(reportOnMovies(movies, language: "sp")!)
```

## Closure Syntax

```swift
// generic
{ (parameters) -> return type in
    statements
}

// capture a closure in a variable
var doubler = { (a: Int) -> Int in
    return a * 2
}
print(doubler(22))

// close over "number" and define function
var number = 0
var addOne = {
    number += 1
}
addOne()
addOne()
print(number)
```

## Functions as Arguments

```Array```'s ```sort(_:)``` is a higher order function because it takes
a sorting function as an argument.

```swift
let firstAndLastStrings = ["Johann S. Bach",
                           "Claudio Monteverdi",
                           "Duke Ellington",
                           "W. A. Mozart",
                           "Nicolai Rimsky-Korsakov",
                           "Scott Joplin",
                           "Josquin Des Prez"]

print(firstAndLastStrings.sort {(a, b) -> Bool in
    return a < b
    })
```

* What are higher order functions?
* Why pass functions?
