# Standards

## Language Fundamentals.

# Functions.-

LF.5 Understand how functions enable us to call a block of reusable code. Utilize functions effectively to recycle functionalities across modules and keep code DRY.

LF.5.a Define and call functions. Understand the components of a function signature including definition vs. invocation, terminology - e.g. 'argument'.

LF.5.b Understand that functions retain the scope at which they are declared.

 

## Engineering Foundation. 

Critical Thinking and Problem Solving.-

## EF.1 Identify a problem or challenge, conceptualize a way (or multiple ways) to approach it, consider potential effects of additional factors, and test different solutions until they find one that works. Break down complex problems into their component parts, form hypotheses to test them, consider the effects of additional factors, and eliminate potential problems one by one.



# Objectives
Students will be able to:
* Gain greater facility with functions
* Use less common forms of functions

# Vocabulary
function, argument, parameter, input, output, scope

# Resources
Apple's [Swift Language Reference, Functions](https://docs.swift.org/swift-book/LanguageGuide/Functions.html)

[What's an algorithm?](https://www.youtube.com/watch?v=6hfOvs8pY1k)

# Lecture

## Functions Day 2 and Review

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

Writing code this way avoids long optional chains, and can be helpful for understanding the flow of a program.


## 2: Introduction to Algorithms

An **algorithm** is a set of step-by-step operations that accomplishes a task.

Here's an example of an algorithm:

```
"Take 2 slices of bread"
"Put 2 tablespoons of jelly on each slice"
"Apply 2 tablespoons of peanut butter the same way"
"Join the slices of bread together"
"Have fun!"
```

Lets see it in action: [Link](https://www.youtube.com/watch?v=XWe4iohhmIw)

What did you notice from the video?

Why did some of the demonstrators not do what you might expect?


Here is a common algorithm called "FizzBuzz"

```
1. Count from 1 to 100 according to the following rules
2. If the current number is divisible by 3, write "Fizz".
3. If the current number is divisible by 5, write "Buzz".
4. If the current number is divisible by 3 and 5, write "FizzBuzz".
5. Otherwise, write the current number.
```

###Practice:  Write FizzBuzz in Swift

<details>
	<summary>One solution</summary>

	for i in 1...100 {
		switch i {
			case _ where i % 15 == 0:
				print("FizzBuzz")
			case _ where i % 3 == 0:
				print("Fizz")
			case _ where i % 5 == 0:
				print("Buzz")
			default:
				print(i)
		}
	}

</details>

Your solution might look totally different.  There are an infinite amount of ways to solve this problem.   Here's another solution:

<details>
	<summary>Another solution</summary>

	if i == 1 { print("1") }
	if i == 2 { print("2") }
	if i == 3 { print("Fizz") }
	if i == 4 { print("4") }
	if i == 5 { print("Buzz") }
	if i == 6 { print("Fizz") }
	if i == 7 { print("7") }
	if i == 8 { print("8") }
	if i == 9 { print("Fizz") }
	if i == 10 { print("Buzz") }
	if i == 11 { print("11") }
	if i == 12 { print("Fizz") }
	if i == 13 { print("13") }
	if i == 14 { print("14") }
	if i == 15 { print("FizzBuzz") }
	if i == 16 { print("16") }
	if i == 17 { print("17") }
	if i == 18 { print("Fizz") }
	if i == 19 { print("19") }
	if i == 20 { print("Buzz") }
	if i == 21 { print("Fizz") }
	if i == 22 { print("22") }
	if i == 23 { print("23") }
	if i == 24 { print("Fizz") }
	if i == 25 { print("Buzz") }
	if i == 26 { print("26") }
	if i == 27 { print("Fizz") }
	if i == 28 { print("28") }
	if i == 29 { print("29") }
	if i == 30 { print("FizzBuzz") }
	if i == 31 { print("31") }
	if i == 32 { print("32") }
	if i == 33 { print("Fizz") }
	if i == 34 { print("34") }
	if i == 35 { print("Buzz") }
	if i == 36 { print("Fizz") }
	if i == 37 { print("37") }
	if i == 38 { print("38") }
	if i == 39 { print("Fizz") }
	if i == 40 { print("Buzz") }
	if i == 41 { print("41") }
	if i == 42 { print("Fizz") }
	if i == 43 { print("43") }
	if i == 44 { print("44") }
	if i == 45 { print("FizzBuzz") }
	if i == 46 { print("46") }
	if i == 47 { print("47") }
	if i == 48 { print("Fizz") }
	if i == 49 { print("49") }
	if i == 50 { print("Buzz") }
	if i == 51 { print("Fizz") }
	if i == 52 { print("52") }
	if i == 53 { print("53") }
	if i == 54 { print("Fizz") }
	if i == 55 { print("Buzz") }
	if i == 56 { print("56") }
	if i == 57 { print("Fizz") }
	if i == 58 { print("58") }
	if i == 59 { print("59") }
	if i == 60 { print("FizzBuzz") }
	if i == 61 { print("61") }
	if i == 62 { print("62") }
	if i == 63 { print("Fizz") }
	if i == 64 { print("64") }
	if i == 65 { print("Buzz") }
	if i == 66 { print("Fizz") }
	if i == 67 { print("67") }
	if i == 68 { print("68") }
	if i == 69 { print("Fizz") }
	if i == 70 { print("Buzz") }
	if i == 71 { print("71") }
	if i == 72 { print("Fizz") }
	if i == 73 { print("73") }
	if i == 74 { print("74") }
	if i == 75 { print("FizzBuzz") }
	if i == 76 { print("76") }
	if i == 77 { print("77") }
	if i == 78 { print("Fizz") }
	if i == 79 { print("79") }
	if i == 80 { print("Buzz") }
	if i == 81 { print("Fizz") }
	if i == 82 { print("82") }
	if i == 83 { print("83") }
	if i == 84 { print("Fizz") }
	if i == 85 { print("Buzz") }
	if i == 86 { print("86") }
	if i == 87 { print("Fizz") }
	if i == 88 { print("88") }
	if i == 89 { print("89") }
	if i == 90 { print("FizzBuzz") }
	if i == 91 { print("91") }
	if i == 92 { print("92") }
	if i == 93 { print("Fizz") }
	if i == 94 { print("94") }
	if i == 95 { print("Buzz") }
	if i == 96 { print("Fizz") }
	if i == 97 { print("97") }
	if i == 98 { print("98") }
	if i == 99 { print("Fizz") }
	if i == 100 { print("Buzz") }

</details>

### Discussion:
- Why is the first solution better than the second one?

## Why is any of this important?
1. It will make you a better programmer
2. It will enable you to pass technical interviews
3. It's interesting!


## How to solve algorithms
1. Clarify the problem
2. Identify the function signature
3. Explain a possible solution in words and images
4. Code the solution
5. Test and refactor the solution

Example:

**Write a function that returns the sum of all the even numbers in an Array of Ints.**

<details>
	<summary> 1. Clarify the problem</summary>

	Is zero even or odd?
	Can negative numbers be even?

</details>

<details>
	<summary> 2a. What are the inputs?</summary>

	An array of Ints as an [Int]

</details>

<details>
	<summary> 2b. What are the outputs?</summary>

	The sum of the even numbers as an Int.

</details>

<details>
	<summary> 3. Explain a possible solution</summary>

	- Initialize a variable Int called "sum" and set sum equal to zero
	- Iterate through the array of Ints
	- Check each Int if even by checking if the Int is divisible by two
	- If the Int is divisible by two, increment sum by the number
	- Return sum after you check each Int

</details>

<details>
	<summary> 4. Code the solution </summary>

	func sumAllEven(arr: [Int]) -> Int {
		var sum = 0
		for num in arr {
			if num % 2 == 0 {
				sum += num
			}
		}
		return sum
	}
</details>

<details>
	<summary> 5. Test and refactor the solution </summary>

	input: [2,5,7,6]
	output: 8

</details>


### **Practice Problem One**

**Write a function that returns how many vowels are in a String**

*Sample Input*: "Hello there!  How's it going?"

*Sample Output*: 8



### **Practice Problem Two**

**Write a function that returns the product of an array of Ints with any zeros taken out**

*Sample Input*: [4,0,8,3,0]

*Sample Output*: 96


### **Practice Problem Three**

**All Ints appear twice in an array, but one element appears only once.  Find the outlier.**

*Sample Input*: [4,0,7,8,3,0,4,3,8]

*Sample Output*: 7


### **Practice Problem Four**

Write a function that capitalizes the first letter of each word in a string



### **Practice Problem Five**

Write a function that returns whether an Array of Ints contains any numbers divisible by 13


### **Practice Problem Six**

Write a function that reverses a String without using built-in reverse methods (i.e don't write ~.reversed()")

### **Practice Problem Seven**

Write a function that "safely" accesses a value in an array of Ints at a given index.

### **Practice Problem Eight**

Given a Dictionary as input that maps Strings to Ints, return a Dictionary that gets rid of entries that map to a negative value.

### **Practice Problem Nine**

Given a String as input, rotate all a-z characters by one.

a -> b, b -> c ... z -> a




# Extra Material Grabbag

## Parameters

### In-out parameters

From Apple's The Swift Programming Language (Swift 4)

Function parameters are constants by default. Trying to change the value of a function parameter from within the body of that function results in a compile-time error. This means that you can’t change the value of a parameter by mistake. If you want a function to modify a parameter’s value, and you want those changes to persist after the function call has ended, define that parameter as an in-out parameter instead.

You write an in-out parameter by placing the inout keyword right before a parameter’s type. An in-out parameter has a value that is passed in to the function, is modified by the function, and is passed back out of the function to replace the original value. For a detailed discussion of the behavior of in-out parameters and associated compiler optimizations, see In-Out Parameters.

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
func myFuncWithOptionalReturnType() -> String? {
    let someNumber = arc4random() % 100
    if someNumber > 50 {
        return "someString"
    } else {
        return nil
    }
}

myFuncWithOptionalReturnType()
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
* What's the difference between `guard` and `if`?
* What's the benefit of the limited scope inside a function?
* Compare and contrast a function's signature with its type.

