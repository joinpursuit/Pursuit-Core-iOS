# Standards
* Master the use of functions

# Objectives
Students will be able to:
* Gain greater facility with functions
* Use less common forms of functions

# Vocabulary: function, argument, parameter, input, output, scope

# Resources
Swift Programming: The Big Nerd Ranch Guide, Chapter 12, Functions

Apple's [Swift Language Reference, Functions](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Functions.html#//apple_ref/doc/uid/TP40014097-CH10-ID158)

# Lecture

#Functions Day 2 and Review

## 1: Guard Statements

So far, we have seen several different types of control flow statements.

- break
- continue
- if/else
- switch

All of these provide excellent ways to navigate code and control the way in which code is executed. 

One special type of if statement is the if let statement.  We use it primarily for optional binding.

```swift
var myInt: Int?
if let int = myInt {
	print(int)
	//More code with int here
}
```
If we have multiple optionals we need to unwrap each one separately.

```swift
func doStuff(myInt: Int?, myString: String?, myDouble: Double?) {
	if let int = myInt {
		if let str = myString {
		   if let double = myDouble {
		   		print(int, str, double)
		   		//More code here
		   }
		}
	}
}
```
This is called the *optional pyramid of doom* because code keeps getting more and more indented.

We can use comma syntax to make it a little better, but it can be difficult to fit too many things on a single line.

Fortunately, we have a better way to handle control flow: the *guard* statement.

The guard statement can only appear inside of a loop or a function.  Let's see an example:

```swift
//If statement

func firstElement(in arr: [Int]) -> Int? {
	if arr.count < 1 {
		return nil
	} else {
		return arr[0]
	}
}

//Guard statement

func firstElement(in arr: [Int]) -> Int? {
	guard arr.count > 0 else {
		return nil
	}
	return arr[0]
}

```

Guard reads the opposite way of if.  In the above example, we would say:

Make sure that the array's count is bigger than 0, if it's not return nil.

We can also use *guard let* like how we would use an *if let*.

```swift
func doStuff(myInt: Int?, myString: String?, myDouble: Double?) {
	guard let int = myInt else {
		return
	}
	guard let str = myString else {
		return
	}
	guard let double = myDouble else {
		return
	}
	print(int, str, double)
	//More code here
}
```

Writing code this way avoids long optional chains, and can be helpful fo understanding the flow of a program.


## 2: Strings

Write your own String() method

Write a function that reverses a String

Write a function that capitalizes the first character in a String

Write a function that capitalizes the first letter of each word in a string (words are spearated by whitespace characters)

Write a function that checks if a String is a Palindrome

Write a function that checks if a String is a pangram


## 3: Arrays

Write your own 'contains' function

Write your own min() and max() functions

Write a function that sums an array

Write a function that concatonates all Strings in an array

Given two arrays of Ints, write a function that tells you all the values they have in common

Write a function that "safely" accesses a value in an array of Ints at a given index.

## 4: Dictionaries

Find the most frequently appearing Array in an Array of Arrays

All Ints appear twice in an array, but one element appears only once.  Find the outlier.

Given a Dictionary as input that maps Strings to Ints, return a Dictionary that gets rid of entries that map to a negative value.

Given a String as input, rotate all a-z characters by one.

a -> b, b -> c ... z -> a











# Extra Material

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
