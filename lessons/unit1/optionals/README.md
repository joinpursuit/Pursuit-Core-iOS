# Optionals

### Objective

* To understand the purpose of optionals
* To learn how to declare, unwrap, bind and chain optionals
* To understand how optionals contribute to the writing of idiomatic Swift

### Reading

1. Swift Programming: The Big Nerd Ranch Guide, Chapter 8
1. [Swift Language Reference, The Basics - Apple](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309) *Seek to Optionals* in right hand menu.

#### Further Reading

#### Vocabulary

- **optional** - A Swift type that wraps another allowing it to either have a value or be nil.
- **initialize** - To assign a variable or constant its first value.
- **nil** - A special value meaning "no value". Only Optionals can be nil in Swift.
- **bind** - The mechanism used to test an `Optional` for a value and assign it to a non-Optional.
- **idiomatic** - In the context of a programming language, code written in a way natural way for that language, using its conventions and features. 
- **nest v.** - To place code blocks inside of other code blocks. One could speak of any combination of conditionals, functions, closures being nested within one another.
- **diagnostic n.** - A diagnostic is a piece of code or other mechanism whose purpose is to find the answer to a question or problem, not to accomplish functionality of the application.
- **lifecycle** - The progressive states an object or piece of software can progress through over time.

---

### Introduction

You use optionals in situations where a value may be absent. An optional represents two possibilities: Either there is a value, and you can unwrap the optional to access that value, or there isn’t a value at all.

#### Warm up

Thought experiment. Imagine we’re writing code that interfaces with a digital thermometer. This thermometer populates one Swift variable called `temperature`. When we first plug in the thermometer what value should we give it? 

#### Exercise 

1. Declare and initialize a variable of type Double called `temperature`.

	<details>
	<summary>Solution</summary>
	```swift
	var temperature = 0.0
	```
	</details>

1. How would you re-initialize `temperature`?

	<details>
	<summary>Solution</summary>	```swift
	var temperature = 0.0
	temperature = -273.0
	temperature = 212.0

	// "re-initialize"
	temperature = 0.0
	```
	</details>

1. How might you try to give it no value at all?

	<details>
	<summary>Solution</summary>
	```swift
	// this is allowed
	var temperature: Double

	// but then this crashes
	if temperature < 10 {
	    print(temperature)
	}
	```

	You could do this:
	```swift
	var temperature: Double
	temperature = 9

	if temperature < 10 {
	    print(temperature)
	}

	// but you never use temperature in any way  
	// until you assign it a value
	```
	</details>

Let's re-declare temperature as an Optional

```swift
var temperature: Double?

// we'll soon learn a better way of doing this
if temperature != nil && temperature! < 10 {
    print(temperature!)
}
```

Note, we no longer have to initialize it. Or more accurately, it's automatically initialized to nil. In addition to helping us write safer code, which we'll explore later, Optionals can make our code easier to read. We know that this variable, an optional, may or may not have a value (i.e. it may be nil).

# Exercises

Declare an optional String, Int, and Double.

```swift
// imagine a book selling app
// a book may or may not have a dedication, reviews or a discount
var bookDedication: String?
var bookReviewCount: Int?
var bookDiscount: Double?
```

Print an assigned optional. What do you see?

```swift
print(bookDedication)

// prints 'nil'
```

Declare a non-optional without assigning it and print it
```swift
var bookTitle: String
print(bookTitle)
// error: variable 'bookTitle' used before being initialized
```

Declare two variables, one as a non-Optional and another as an Optional of that type. 
Try assigning them to one another.

```swift
var bookTitle: String = "The Hobbit"
var secondTitle: String?
//secondTitle = "There and Back Again"
print(bookTitle)

secondTitle = bookTitle // this works
print(secondTitle)

bookTitle = secondTitle // this doesn't

// we need to unwrap secondTitle
bookTitle = secondTitle! // ! force-unwraps (not the best way in _most_ cases)
```

## Exercises

1. Force unwrap an optional and print.
1. Force unwrap an unset optional and print.

Observe how Force unwrapping can trigger runtime errors (crash).

**Questions**: 

* What is the difference between a compile time error and a run time error. 
* Which is better?
* How do optionals protect us from run time errors?

Force unwrapping essentially disables this protection.

## Optional Binding
Binding to the rescue. Binding allows us to query an optional for set/nil status. 

```swift
var bookTitle: String = "The Hobbit"
var secondTitle: String?
secondTitle = "There and Back Again"

if let title = secondTitle {
    print("Full title: \(bookTitle) or \(title)")
}
else {
    print("Full title: \(bookTitle)")
}
```
### Unwrapping multiple optionals

Consider this nested unwrapping of optionals:

```swift
var bookReviewCount: Int?
var avgStarRating: Double?
var bookTitle: String = "The Hobbit"

bookReviewCount = 28
avgStarRating = 2.9
if let count = bookReviewCount {
    if let rating = avgStarRating {
        if (rating > 3) {
            print("\(bookTitle): \(rating) stars")
        }
        else {
            print("\(bookTitle)")
        }
    }
}
else {
    print("\(bookTitle)")
}
```

```swift
var bookReviewCount: Int?
var avgStarRating: Double?
var bookTitle: String = "The Hobbit"

bookReviewCount = 28
avgStarRating = 2.9
if let count = bookReviewCount, rating = avgStarRating {
    if (rating > 3) {
        print("\(bookTitle): \(rating) stars")
    }
    else {
        print("\(bookTitle)")
    }
}
else {
    print("\(bookTitle)")
}
```

### Optional Binding with a ```where``` clause

The example above can be reduced further with a ```where``` clause, if applicable.

```swift
if let count = bookReviewCount,
    rating = avgStarRating where rating > 3 {
    print("\(bookTitle): \(rating) stars")
}
else {
    print("\(bookTitle)")
}
```

## Exercises

Bind an optional and print its value, include an else block with a message.

```swift
var bookEndorsement: String?

if let endorsement = bookEndorsement {
	print("Endorsement: \(endorsement)")
}
else {
	print("There was no endorsement.")
}
```

Bind two optionals, first nested and then in one binding ```if```.

```swift
var firstName: String?
var lastName: String?

// comment/uncomment these two lines to test the bindings below
firstName = "Isabel"
lastName = "Archer"

// nested implementation
// note how we reuse the identifier; that's ok
if let firstName = firstName {
	if let lastName = lastName {
		print("Name: \(firstName) \(lastName)")
	}
	else {
		print("First Name: \(firstName)")
	}
}
else {
	print("Neither name was set.")
}

// same-line implementation
if let firstName = firstName, lastName = lastName {
	print("Name: \(firstName) \(lastName)")
}
else {
	print("Neither name was set.")
}
```
Note how the same line implementation is shorter. 

**Questions**: 

Are the two blocks logically equivalent?

```
No.
```

Can they be made to be?

```
No.
```

What's the difference?

```
The nested version allows us to treat the case where the first name is set but the last name is not.
The same line only branches to two directions: both are set or neither is set. 
```

Can the first option detect if the specific case where lastName is set but firstName is not?

```
No, it cannot. This reveals an inherent limitation of optional binding in the context of cross
dependent variables. This is a case where testing for nil on an optional results in clearer code.
```

## Exercises

Build a pyramid of doom (three nested optionals) and a multiply bound version.

```
TODO: ANSWER
```

### Implicitly Unwrapped Optionals

Implicitly unwrapped optionals don't need to be unwrapped when used. This seems odd, and at this point
before we've dealt with writing our own classes it is odd. For now, don't declare implicitly unwrapped 
optionals, but let's be ready to use them when we see them.

```swift
var firstName: String!
firstName = "Caspar"
print(firstName)
```

### Modifying an optional in place

```swift
lastName?.appendContentsOf(", Esq.")
lastName?.removeAll()
```

#### NYT

Explore the String documentation and find other methods that modify the string like 
```appendContentsOf(_:)``` does

### The nil coalescing operator

```swift
let mn = middleName ?? "X."
```
Good to ask yourself whether a feature is for new functionality, clarity, brevity. Many of these have tradeoffs.

## Optional chaining

Optional chaining is a process for querying and calling properties, methods, and subscripts on an optional 
that might currently be nil. If the optional contains a value, the property, method, or subscript call
succeeds; if the optional is nil, the property, method, or subscript call returns nil.
Multiple queries can be chained together, and the entire chain fails gracefully if any link in the chain is nil.

The result of an optional chaining call is always an optional value, even if the property, method, or subscript you are querying returns a non-optional value.

You can also attempt to set a property’s value through optional chaining.

If the type you are trying to retrieve is not optional, it will become optional because of the optional chaining.
If the type you are trying to retrieve is already optional, it will not become more optional because of the chaining.

```swift
var errorCodeString: String?
errorCodeString = "404"
var errorDescription: String?
if let theError = errorCodeString, errorCodeInteger = Int(theError)
	where errorCodeInteger == 404 {
	errorDescription = ("\(errorCodeInteger + 200): request not found")
} 

var upCaseErrorDescription = errorDescription?.uppercaseString
errorDescription
```

