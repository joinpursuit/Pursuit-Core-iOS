# Standards
* Master the use of functions

# Objectives
Students will be able to:
* Gain greater facility with functions
* Use less common forms of functions

### Vocabulary: function, argument, parameter, input, output, scope

# Resources
Swift Programming: The Big Nerd Ranch Guide, Chapter 12, Functions

Apple's [Swift Language Reference, Functions](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Functions.html#//apple_ref/doc/uid/TP40014097-CH10-ID158)

# Lecture

## Parameters

### In-out parameters

From Apple's The Swift Programming Language (Swift 2.2)

Function parameters are constants by default. Trying to change the value of a function parameter from within the body of that function results in a compile-time error. This means that you can’t change the value of a parameter by mistake. If you want a function to modify a parameter’s value, and you want those changes to persist after the function call has ended, define that parameter as an in-out parameter instead.

You write an in-out parameter by placing the inout keyword at the start of its parameter definition. An in-out parameter has a value that is passed in to the function, is modified by the function, and is passed back out of the function to replace the original value. For a detailed discussion of the behavior of in-out parameters and associated compiler optimizations, see In-Out Parameters.

You can only pass a variable as the argument for an in-out parameter. You cannot pass a constant or a literal value as the argument, because constants and literals cannot be modified. You place an ampersand (&) directly before a variable’s name when you pass it as an argument to an in-out parameter, to indicate that it can be modified by the function.

Good to know these exist. Don't use this. But here's an example:

```swift
var name1 = "Mr. Potato"
var name2 = "Mr. Roboto"

func nameSwap(inout name1: String, inout _ name2: String) {
    let oldName1 = name1
    name1 = name2
    name2 = oldName1
}

nameSwap(&name1, &name2)

print(name1, name2)
```
### Variadic parameters

Good to know these exist. Don't use this. 

## Return

### Optional Return Types

A trivial example.

```swift
func atoi2(s: String) -> Int? {
    let i = Int(s)
    return i
}
```

A strange variation.

```swift
func hyperAtoi(s: String) -> Int? {
    for r in [2, 8, 10, 16] {
        if let i = Int(s, radix: r) {
            return i
        }
    }
    return nil
}
```

Using a random number generator again simply to give us variation.

```swift
func myFuncWithOptonalReturnType() -> String? {
    let someNumber = arc4random() % 100
    if someNumber > 50 {
        return "someString"
    } else {
        return nil
    }
}

myFuncWithOptonalReturnType()
```

Let's look at a more realistic and familiar example.

```swift
func reportOnMovies(movies:[[String:Any]]) -> String? {
    var output: String?
    for movie in movies {
        if let name = movie["name"] as? String, year = movie["year"] as? Int, cast = movie["cast"] as? [String] {
            if output == nil {
                output = ""
            }
            
            var castString = ""
            for (i, actor) in cast.enumerate() {
                if i == cast.count - 1 {
                    castString += "and \(actor)"
                }
                else {
                    castString += "\(actor), "
                }
            }
            output?.appendContentsOf("\(name) came out in \(year) starring \(castString).")
            if let president = presidentsByYear[year] {
                output?.appendContentsOf("\(president) was president.")
            }
            output?.appendContentsOf("\n")
        }
    }
    return output
}

print(reportOnMovies(movies)!)

let movies2: [[String:Any]] = []
if let report = reportOnMovies(movies2) {
    print(report)
}
else {
    print("Can't say anything")
}
```

### Multiple Returns

```swift
func findRangeFromNumbers(numbers: Int...) -> (min: Int, max: Int) {
    
    var min = numbers[0]
    var max = numbers[0]
    
    for number in numbers {
        if number > max {
            max = number
        }
        
        if number < min {
            min = number
        }
    }
    
    return (min, max)
}

print(findRangeFromNumbers(1, 234, 555, 345, 423))
```
## ```guard```: Exiting Early from a Function

Another tool to assist in reducing the number and depth of pyramids of doom.

```swift
func reportOnMovies(movies:[[String:Any]]) -> String? {
    var output: String? = ""
    for movie in movies {
        if let name = movie["name"] as? String, year = movie["year"] as? Int, cast = movie["cast"] as? [String] {
            var castString = ""
            for (i, actor) in cast.enumerate() {
                if i == cast.count - 1 {
                    castString += "and \(actor)"
                }
                else {
                    castString += "\(actor), "
                }
            }
            output?.appendContentsOf("\(name) came out in \(year) starring \(castString).")
            if let president = presidentsByYear[year] {
                output?.appendContentsOf("\(president) was president.")
            }
            output?.appendContentsOf("\n")
        }
    }
    return output
}

func generateMovieReport(movieArray:[[String:Any]]?) -> String? {
    // we absolutely need movie array
    guard let movieArray = movieArray else {
        return nil
    }
    
    var output: String = ""
    for movie in movieArray {
        // we can continue execution if one of these is missing but we want to skip it
        guard let name = movie["name"] as? String, year = movie["year"] as? Int, cast = movie["cast"] as? [String] else {
            continue
        }

        var castString = ""
        for (i, actor) in cast.enumerate() {
            if i == cast.count - 1 {
                castString += "and \(actor)"
            }
            else {
                castString += "\(actor), "
            }
        }
        
        output += "\(name) came out in \(year) starring \(castString)."

        if let president = presidentsByYear[year] {
            output.appendContentsOf(" \(president) was president.")
        }
        
        output += "\n"
    }
    
    return output
}

if let report = generateMovieReport(movies) {
    print(report)
}
else {
    print("Nothing to report")
}
```

## Scope

```swift
// global Scope
let i = 2
func iScopeMadness () {
    // function scope
    let i = 3
    do {
        // arbitrary block scope
        let i = 5
        if true {
            // if block scope
            let i = 7
            // for scope (generate odds in range)
            for i in 11...13 where i % 2 == 1 {
                print(i)
            }
            print(i)
        }
        print(i)
    }
    print(i)
}
print(i)
print(iScopeMadness())
```

### Nested Functions

Good to know these exist. Don't create any. But here's one:

```swift
func reportOnMovies(movies:[[String:Any]]) -> String? {
    func buildCommaSeparatedList(words: [String]) -> String {
        var output = ""
        for (i, word) in words.enumerate() {
            if i == words.count - 1 {
                output += "and \(word)"
            }
            else {
                output += "\(word), "
            }
        }
        return output
    }
    
    var output: String?
    for movie in movies {
        if let name = movie["name"] as? String, year = movie["year"] as? Int, cast = movie["cast"] as? [String] {
            if output == nil {
                output = ""
            }
            
            let castString = buildCommaSeparatedList(cast)

            output?.appendContentsOf("\(name) came out in \(year) starring \(castString).")
            if let president = presidentsByYear[year] {
                output?.appendContentsOf(" \(president) was president.")
            }
            output?.appendContentsOf("\n")
        }
    }
    return output
}
```

## Function Types

# Review and Wrapup

* What are in-out parameters used for?
* When would you need variadic parameters?
* What's the differencd between ```guard``` and ```if```?
* What's the benefit of the limited scope inside a function?
* Compare and contrast a function's signature with its type.
